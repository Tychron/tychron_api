defmodule Tychron.API.HTTP.Client.Base do
  use HTTPoison.Base

  @impl true
  def process_request_headers(headers) do
    normalize_headers(headers)
  end

  @impl true
  def process_response_headers(headers) do
    normalize_headers(headers)
  end

  defp normalize_headers(headers) do
    Enum.map(headers, fn {key, value} ->
      {String.downcase(key), value}
    end)
  end
end

defmodule Tychron.API.HTTP.Client do
  alias Tychron.API.HTTP.Client.Base, as: Client
  alias Tychron.Config
  alias HTTPoison.Response

  @type method :: HTTPoison.Base.method()

  @type path :: String.t()

  @type query_params :: Keyword.t() | map()

  @type headers :: [{String.t(), String.t()}]

  @type body :: {:json, any()}

  @typedoc """
  Sends the specified options to the underlying HTTP Client
  """
  @type client_options_option :: {:client_options, any()}

  @type request_option :: client_options_option()

  @type request_options :: [request_option()]

  @type response_doc :: {:json, any()} | {:text, any()} | {:unk, any()}

  @type http_response :: {:ok, Response.t(), response_doc()}

  @spec http_request(method(), path(), query_params(), body(), request_options()) :: http_response()
  def http_request(method, path, query_params, headers, body, options \\ []) do
    options = patch_default_options(options)
    url = build_url(path, options)

    {headers, options} = maybe_add_auth_headers(headers, options)

    case encode_body(body) do
      {:ok, {body_headers, blob}} ->
        new_url = encode_new_url(url, query_params)
        headers = body_headers ++ headers
        client_options = Keyword.get(options, :client_options, [])

        case Client.request(method, new_url, blob, headers, client_options) do
          {:ok, response} ->
            result = decode_body(response, options)
            {:ok, response, result}

          {:error, _} = err ->
            err
        end

      {:error, reason} ->
        {:error, {:encode_body_error, reason}}
    end
  end

  defp build_url(path, options) when is_binary(path) do
    endpoint_url = Keyword.fetch!(options, :endpoint_url)

    Path.join(endpoint_url, path)
  end

  defp patch_default_options(options) do
    options =
      # add the default endpoint_url unless it already exists
      options
      |> Keyword.put_new_lazy(:endpoint_url, fn ->
        Config.default_endpoint_url()
      end)

    # check if the auth method exists
    case Keyword.fetch(options, :auth_method) do
      {:ok, _} ->
        # it does, do not patch any other auth details
        options

      :error ->
        # it doesn't exist, force the default auth
        options
        |> Keyword.put(:auth_method, Config.default_auth_method())
        |> Keyword.put(:auth_identity, Config.default_auth_identity())
        |> Keyword.put(:auth_secret, Config.default_auth_secret())
    end
  end

  defp maybe_add_auth_headers(headers, options) do
    {auth_method, options} = Keyword.pop(options, :auth_method, "none")
    {username, options} = Keyword.pop(options, :auth_identity)
    {password, options} = Keyword.pop(options, :auth_secret)

    headers =
      case to_string(auth_method) do
        "none" ->
          headers

        "basic" ->
          auth = Base.encode64("#{username}:#{password}")

          [
            {"authorization", "Basic #{auth}"}
            | headers
          ]

        "bearer" ->
          [
            {"authorization", "Bearer #{password}"}
            | headers
          ]

        _ ->
          headers
      end

    {headers, options}
  end

  defp encode_body(nil) do
    {:ok, {[], ""}}
  end

  defp encode_body({:form_urlencoded, term}) when is_list(term) or is_map(term) do
    blob = encode_query_params(term)
    headers = [{"content-type", "application/x-www-form-urlencoded"}]
    {:ok, {headers, blob}}
  end

  defp encode_body({:text, term}) do
    blob = IO.iodata_to_binary(term)
    headers = [{"content-type", "text/plain"}]
    {:ok, {headers, blob}}
  end

  defp encode_body({:json, term}) do
    case Jason.encode(term) do
      {:ok, blob} ->
        headers = [{"content-type", "application/json"}]
        {:ok, {headers, blob}}

      {:error, _} = err ->
        err
    end
  end

  defp encode_body(binary) when is_binary(binary) do
    {:ok, {[], binary}}
  end

  defp decode_body(%Response{
    request: %{
      headers: req_headers,
    },
    headers: res_headers,
    body: body
  }, _options) do
    # retrieve the original request accept header, this will be used to "allow" the content-type
    # to be parsed
    accept =
      case :proplists.get_value("accept", req_headers) do
        :undefined -> nil
        other -> other
      end

    # retrieve the response content-type
    content_type =
      case :proplists.get_value("content-type", res_headers) do
        :undefine -> nil
        other -> other
      end

    # ensure that we only parse content for the given accept header to avoid parsing bodies we
    # didn't want or even expect
    accepted_content_type =
      case accept do
        nil ->
          # no accept header was given, expect to parse anything, this is dangerous
          # but allows the default behaviour to continue
          # you should ALWAYS specify an accept header
          content_type

        _ ->
          if content_type do
            # a content-type was returned, try negotiate with the accept header and content-type
            case :accept_header.negotiate(accept, [content_type]) do
              :undefined ->
                # mismatch accept and content-type, refuse to parse the content and return
                # nil for the accepted_content_type
                nil

              name when is_binary(name) ->
                # return the matched content_type
                name
            end
          else
            # there was no content-type, return nil
            nil
          end
      end

    type =
      if accepted_content_type do
        case Plug.Conn.Utils.content_type(accepted_content_type) do
          {:ok, "application", "json", _params} ->
            # parse standard json
            :json

          {:ok, "text", "plain", _params} ->
            # return plain text as is
            :text

          {:ok, _, _, _} ->
            # some other content-type, return it as unknown
            :unk

          :error ->
            # the content-type failed to parse, return it as unknown as well
            :unk
        end
      else
        # no content-type or mismatched content-type and accept, return unk(nown)
        :unk
      end

    case type do
      :json ->
        case Jason.decode(body) do
          {:ok, doc} ->
            {type, doc}

          {:error, _} ->
            {:unk, body}
        end

      type ->
        {type, body}
    end
  end

  defp encode_query_params(nil) do
    nil
  end

  defp encode_query_params(query_params) when is_list(query_params) or is_map(query_params) do
    Plug.Conn.Query.encode(query_params)
  end

  defp encode_new_url(url, query_params) do
    case encode_query_params(query_params) do
      nil ->
        url

      "" ->
        url

      qp ->
        uri = URI.parse(url)
        uri = %{uri | query: qp}
        URI.to_string(uri)
    end
  end
end
