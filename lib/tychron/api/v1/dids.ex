defmodule Tychron.API.V1.DIDs do
  use Tychron.API.HttpContextBase, endpoint_type: :api

  @type did_id :: Ecto.UUID.t()

  @type did_number :: String.t()

  @type did_id_or_number :: did_id() | did_number()

  @spec update_did(did_id_or_number(), map(), Keyword.t()) :: context_response(Tychron.M.DID.t())
  def update_did(did_id_or_number, params, options \\ []) do
    doc = to_req_document(params, "did")
    http_request(:patch, "/api/v1/numbers/#{did_id_or_number}", @no_query_params, @no_headers, {:json, doc}, options)
    |> maybe_decode_response_document(%{
      200 => Tychron.M.DID,
    })
  end

  @spec list_dids(map(), Keyword.t()) :: context_page_response(Tychron.M.DID.t())
  def list_dids(query_params, options \\ []) do
    http_request(:get, "/api/v1/numbers", query_params, @no_headers, nil, options)
    |> maybe_decode_response_page(%{
      200 => Tychron.M.DID,
    })
  end

  @spec get_did(did_id_or_number(), Keyword.t()) :: context_response(Tychron.M.DID.t())
  def get_did(did_id_or_number, options \\ []) do
    http_request(:get, "/api/v1/numbers/#{did_id_or_number}", @no_query_params, @no_headers, nil, options)
    |> maybe_decode_response_document(%{
      200 => Tychron.M.DID,
    })
  end
end
