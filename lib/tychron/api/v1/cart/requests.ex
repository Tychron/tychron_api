defmodule Tychron.API.V1.Cart.Requests do
  use Tychron.API.HttpContextBase, endpoint_type: :api

  @type cart_id :: Ecto.ULID.t()

  @type request_id :: Ecto.ULID.t()

  @spec create_cart_request(cart_id(), map(), Keyword.t()) :: context_response(Tychron.M.Cart.Request.t())
  def create_cart_request(cart_id, params, options \\ []) do
    doc = to_req_document(params, "cart")
    http_request(:post, "/api/v1/carts/#{cart_id}/requests", @no_query_params, @no_headers, {:json, doc}, options)
    |> maybe_decode_response_document(%{
      201 => Tychron.M.Cart.Request,
    })
  end

  @spec update_cart_request(cart_id(), request_id(), map(), Keyword.t()) :: context_response(Tychron.M.Cart.Request.t())
  def update_cart_request(cart_id, request_id, params, options \\ []) do
    doc = to_req_document(params, "cart")
    http_request(:patch, "/api/v1/carts/#{cart_id}/requests/#{request_id}", @no_query_params, @no_headers, {:json, doc}, options)
    |> maybe_decode_response_document(%{
      200 => Tychron.M.Cart.Request,
    })
  end

  @spec delete_cart_request(cart_id(), request_id(), Keyword.t()) :: context_response(Tychron.M.Cart.Request.t())
  def delete_cart_request(cart_id, request_id, options \\ []) do
    http_request(:delete, "/api/v1/carts/#{cart_id}/requests/#{request_id}", @no_query_params, @no_headers, nil, options)
    |> maybe_decode_response_document(%{
      200 => Tychron.M.Cart.Request,
    })
  end

  @spec list_cart_requests(cart_id(), map(), Keyword.t()) :: context_page_response(Tychron.M.Cart.Request.t())
  def list_cart_requests(cart_id, query_params, options \\ []) do
    http_request(:get, "/api/v1/carts/#{cart_id}/requests", query_params, @no_headers, nil, options)
    |> maybe_decode_response_page(%{
      200 => Tychron.M.Cart.Request,
    })
  end

  @spec get_cart_request(cart_id(), request_id(), Keyword.t()) :: context_response(Tychron.M.Cart.Request.t())
  def get_cart_request(cart_id, request_id, options \\ []) do
    http_request(:get, "/api/v1/carts/#{cart_id}/requests/#{request_id}", @no_query_params, @no_headers, nil, options)
    |> maybe_decode_response_document(%{
      200 => Tychron.M.Cart.Request,
    })
  end
end
