defmodule Tychron.API.V1.DID.Destinations do
  use Tychron.API.HttpContextBase

  @type did_id_or_number :: Tychron.API.V1.DIDs.did_id_or_number()

  @type destination_id :: Ecto.UUID.t()

  @spec create_did_destination(did_id_or_number(), map(), Keyword.t()) :: context_response(Tychron.M.DID.Request.t())
  def create_did_destination(did_id_or_number, params, options \\ []) do
    doc = to_req_document(params, "number_destination")
    http_request(:post, "/api/v1/numbers/#{did_id_or_number}/destinations", @no_query_params, @no_headers, {:json, doc}, options)
    |> maybe_decode_response_document(%{
      201 => Tychron.M.DID.Destination,
    })
  end

  @spec update_did_destination(did_id_or_number(), destination_id(), map(), Keyword.t()) :: context_response(Tychron.M.DID.Request.t())
  def update_did_destination(did_id_or_number, destination_id, params, options \\ []) do
    doc = to_req_document(params, "number_destination")
    http_request(:patch, "/api/v1/numbers/#{did_id_or_number}/destinations/#{destination_id}", @no_query_params, @no_headers, {:json, doc}, options)
    |> maybe_decode_response_document(%{
      200 => Tychron.M.DID.Destination,
    })
  end

  @spec delete_did_destination(did_id_or_number(), destination_id(), Keyword.t()) :: context_response(Tychron.M.DID.Request.t())
  def delete_did_destination(did_id_or_number, destination_id, options \\ []) do
    http_request(:delete, "/api/v1/numbers/#{did_id_or_number}/destinations/#{destination_id}", @no_query_params, @no_headers, nil, options)
    |> maybe_decode_response_document(%{
      200 => Tychron.M.DID.Destination,
    })
  end

  @spec list_did_destinations(did_id_or_number(), map(), Keyword.t()) :: context_page_response(Tychron.M.DID.Request.t())
  def list_did_destinations(did_id_or_number, query_params, options \\ []) do
    http_request(:get, "/api/v1/numbers/#{did_id_or_number}/destinations", query_params, @no_headers, nil, options)
    |> maybe_decode_response_page(%{
      200 => Tychron.M.DID.Destination,
    })
  end

  @spec get_did_destination(did_id_or_number(), destination_id(), Keyword.t()) :: context_response(Tychron.M.DID.Request.t())
  def get_did_destination(did_id_or_number, destination_id, options \\ []) do
    http_request(:get, "/api/v1/numbers/#{did_id_or_number}/destinations/#{destination_id}", @no_query_params, @no_headers, nil, options)
    |> maybe_decode_response_document(%{
      200 => Tychron.M.DID.Destination,
    })
  end
end
