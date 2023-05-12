defmodule Tychron.Support.PlugPipelineHelpers do
  defmodule QueryParamsPipeline do
    @moduledoc false
    use Plug.Builder

    plug Plug.Parsers, parsers: [:urlencoded],
                       pass: ["*/*"]
  end

  defmodule JSONPipeline do
    @moduledoc false
    use Plug.Builder

    plug Plug.Parsers, parsers: [:json],
                       pass: ["application/json", "application/vnd.api+json"],
                       json_decoder: Jason
  end

  @moduledoc false

  import Plug.Conn

  @doc """
  Handles a urlencoded request
  """
  @spec handle_urlencoded_request(Plug.Conn.t()) :: {:ok, map(), Plug.Conn.t()}
  def handle_urlencoded_request(conn) do
    conn = QueryParamsPipeline.call(conn, [])
    {:ok, conn.params, conn}
  end

  @doc """
  Handles a JSON request
  """
  @spec handle_json_request(Plug.Conn.t()) :: {:ok, map(), Plug.Conn.t()}
  def handle_json_request(conn) do
    conn = JSONPipeline.call(conn, [])
    {:ok, conn.params, conn}
  end

  @spec send_json_resp(Plug.Conn.t(), integer, term) :: Plug.Conn.t()
  def send_json_resp(conn, status, doc) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(status, Jason.encode_to_iodata!(doc))
    |> halt()
  end

  @doc """
  Reads the Authorization request header from the given Plug.Conn

  If no Authorization was set, then :none is returned, otherwise:
  * {:basic, {username, password}} for Basic
  * {:bearer, token} for Bearer
  and {:error, term} for everything else or when the authorization was incorrectly formatted
  """
  @spec read_request_auth(Plug.Conn.t()) ::
          :none
          | {:basic, {String.t(), String.t()}}
          | {:bearer, String.t()}
          | {:error, term()}
  def read_request_auth(conn) do
    case get_req_header(conn, "authorization") do
      [] ->
        :none

      [header | _] ->
        case Regex.scan(~r/\ABasic\s+(\S+)\z/i, header) do
          [[_all, digest64]] ->
            case Base.decode64(digest64) do
              {:ok, digest} ->
                [username, password] = String.split(digest, ":", parts: 2)
                {:basic, {username, password}}

              :error ->
                {:error, {:bad_basic_auth, header}}
            end

          [] ->
            case Regex.scan(~r/\ABearer\s+(.+)\z/i, header) do
              [[_all, token]] ->
                {:bearer, token}

              [] ->
                {:error, {:bad_authorization, header}}
            end
        end
    end
  end
end
