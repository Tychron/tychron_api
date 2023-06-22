defmodule Tychron.API.V1.Requests do
  use Tychron.API.HttpContextBase, endpoint_type: :api

  @type request_id :: Ecto.ULID.t()

  @spec update_request(request_id(), map(), Keyword.t()) :: context_response(Tychron.M.Request.t())
  def update_request(request_id, params, options \\ []) do
    doc = to_req_document(params, "request")
    http_request(:patch, "/api/v1/requests/#{request_id}", @no_query_params, @no_headers, {:json, doc}, options)
    |> maybe_decode_response_document(%{
      200 => Tychron.M.Request,
    })
  end

  @spec list_requests(map(), Keyword.t()) :: context_page_response(Tychron.M.Request.t())
  def list_requests(query_params, options \\ []) do
    http_request(:get, "/api/v1/requests", query_params, @no_headers, nil, options)
    |> maybe_decode_response_page(%{
      200 => Tychron.M.Request,
    })
  end

  @spec get_request(request_id(), Keyword.t()) :: context_response(Tychron.M.Request.t())
  def get_request(request_id, options \\ []) do
    http_request(:get, "/api/v1/requests/#{request_id}", @no_query_params, @no_headers, nil, options)
    |> maybe_decode_response_document(%{
      200 => Tychron.M.Request,
    })
  end
end
