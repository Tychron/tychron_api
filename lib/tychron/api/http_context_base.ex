defmodule Tychron.API.HttpContextBase do
  defmacro __using__(_opts \\ []) do
    quote do
      alias Tychron.API.HTTP.Client

      import Client
      import unquote(__MODULE__)

      @type context_response(t) :: unquote(__MODULE__).context_response(t)

      @type context_page_response(t) :: unquote(__MODULE__).context_page_response(t)

      @no_query_params []

      @no_headers []
    end
  end

  alias HTTPoison.Response

  @type context_response(t) :: {:ok, Tychron.M.DocumentResponse.t(t)} | {:error, term()}

  @type context_page_response(t) :: {:ok, Tychron.M.PageResponse.t(t)} | {:error, term()}

  def to_req_document(params) when is_map(params) do
    %{
      "data" => params,
    }
  end

  def to_req_document(params, type) when is_map(params) and (is_binary(type) or is_atom(type)) do
    %{
      "type" => to_string(type),
      "data" => params,
    }
  end

  def maybe_decode_response_page(
    {:ok, %Response{status_code: status_code} = response, {:json, doc} = data},
    map
  ) when status_code >= 200 and status_code < 300 and is_map(map) do
    case Map.fetch(map, status_code) do
      :error ->
        {:error, {:unhandled_response, response, {:json, doc}}}

      {:ok, schema} ->
        page_result = Ecto.embedded_load(Tychron.M.PageResult, doc, :json)

        page_result = put_in(page_result.results, Enum.map(page_result.results, fn
          %Tychron.M.Document{} = subject ->
            put_in(subject.data, Ecto.embedded_load(schema, subject.data, :json))
          end
        ))

        {:ok, %Tychron.M.PageResponse{
          response: response,
          response_data: data,
          page_result: page_result,
        }}
    end
  end

  def maybe_decode_response_page(
    {:ok, %Response{status_code: status_code} = response, {:json, doc} = data},
    _map
  ) when status_code == 400 or status_code == 422 do
    %{
      "errors" => errors,
    } = doc

    page_result = Ecto.embedded_load(Tychron.M.PageResult, doc, :json)

    errors =
      Enum.map(errors, fn %{"code" => "invalid_parameter"} = error ->
        Ecto.embedded_load(Tychron.M.Errors.InvalidParameter, error, :json)
      end)

    {:error, %Tychron.M.PageResponseError{
      response: response,
      response_data: data,
      page_result: page_result,
      errors: errors,
    }}
  end

  def maybe_decode_response_page({:error, _reason} = err, _map) do
    err
  end

  def maybe_decode_response_document(
    {:ok, %Response{status_code: status_code} = response, {:json, doc} = data},
    map
  ) when status_code >= 200 and status_code < 300 and is_map(map) do
    case Map.fetch(map, status_code) do
      :error ->
        {:error, {:unhandled_response, response, {:json, doc}}}

      {:ok, schema} ->
        item = Ecto.embedded_load(Tychron.M.Document, doc, :json)

        item = put_in(item.data, Ecto.embedded_load(schema, item.data, :json))

        {:ok, %Tychron.M.DocumentResponse{
          response: response,
          response_data: data,
          document: item,
        }}
    end
  end

  def maybe_decode_response_document({:error, _reason} = err, _map) do
    err
  end
end
