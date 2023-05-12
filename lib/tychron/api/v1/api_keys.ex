defmodule Tychron.API.V1.ApiKeys do
  use Tychron.API.HttpContextBase

  @type api_key_id :: Ecto.UUID.t()

  @spec create_api_key(map(), Keyword.t()) :: context_response(Tychron.M.ApiKey.t())
  def create_api_key(params, options \\ []) do
    doc = to_req_document(params, "api_key")
    http_request(:post, "/api/v1/api_keys", @no_query_params, @no_headers, {:json, doc}, options)
    |> maybe_decode_response_document(%{
      201 => Tychron.M.ApiKey,
    })
  end

  @spec update_api_key(api_key_id(), map(), Keyword.t()) :: context_response(Tychron.M.ApiKey.t())
  def update_api_key(api_key_id, params, options \\ []) do
    doc = to_req_document(params, "api_key")
    http_request(:patch, "/api/v1/api_keys/#{api_key_id}", @no_query_params, @no_headers, {:json, doc}, options)
    |> maybe_decode_response_document(%{
      200 => Tychron.M.ApiKey,
    })
  end

  @spec delete_api_key(api_key_id(), map(), Keyword.t()) :: context_response(Tychron.M.ApiKey.t())
  def delete_api_key(api_key_id, query_params, options \\ []) do
    http_request(:delete, "/api/v1/api_keys/#{api_key_id}", query_params, @no_headers, nil, options)
    |> maybe_decode_response_document(%{
      200 => Tychron.M.ApiKey,
    })
  end

  @spec list_api_keys(map(), Keyword.t()) :: context_page_response(Tychron.M.ApiKey.t())
  def list_api_keys(query_params, options \\ []) do
    http_request(:get, "/api/v1/api_keys", query_params, @no_headers, nil, options)
    |> maybe_decode_response_page(%{
      200 => Tychron.M.ApiKey,
    })
  end

  @spec get_api_key(api_key_id(), Keyword.t()) :: context_response(Tychron.M.ApiKey.t())
  def get_api_key(api_key_id, options \\ []) do
    http_request(:get, "/api/v1/api_keys/#{api_key_id}", @no_query_params, @no_headers, nil, options)
    |> maybe_decode_response_document(%{
      200 => Tychron.M.ApiKey,
    })
  end
end
