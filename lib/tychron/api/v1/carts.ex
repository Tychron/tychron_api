defmodule Tychron.API.V1.Carts do
  use Tychron.API.HttpContextBase

  @type cart_id :: Ecto.ULID.t()

  @spec create_cart(map(), Keyword.t()) :: context_response(Tychron.M.Cart.t())
  def create_cart(params, options \\ []) do
    doc = to_req_document(params, "cart")
    http_request(:post, "/api/v1/carts", @no_query_params, @no_headers, {:json, doc}, options)
    |> maybe_decode_response_document(%{
      201 => Tychron.M.Cart,
    })
  end

  @spec update_cart(cart_id(), map(), Keyword.t()) :: context_response(Tychron.M.Cart.t())
  def update_cart(cart_id, params, options \\ []) do
    doc = to_req_document(params, "cart")
    http_request(:patch, "/api/v1/carts/#{cart_id}", @no_query_params, @no_headers, {:json, doc}, options)
    |> maybe_decode_response_document(%{
      200 => Tychron.M.Cart,
    })
  end

  @spec delete_cart(cart_id(), map(), Keyword.t()) :: context_response(Tychron.M.Cart.t())
  def delete_cart(cart_id, query_params, options \\ []) do
    http_request(:delete, "/api/v1/carts/#{cart_id}", query_params, @no_headers, nil, options)
    |> maybe_decode_response_document(%{
      200 => Tychron.M.Cart,
    })
  end

  @spec checkout_cart(cart_id(), Keyword.t()) :: context_response(Tychron.M.Order.t())
  def checkout_cart(cart_id, options \\ []) do
    http_request(:post, "/api/v1/carts/#{cart_id}/checkout", @no_query_params, @no_headers, nil, options)
    |> maybe_decode_response_document(%{
      200 => Tychron.M.Order,
    })
  end

  @spec list_carts(map(), Keyword.t()) :: context_page_response(Tychron.M.Cart.t())
  def list_carts(query_params, options \\ []) do
    http_request(:get, "/api/v1/carts", query_params, @no_headers, nil, options)
    |> maybe_decode_response_page(%{
      200 => Tychron.M.Cart,
    })
  end

  @spec get_cart(cart_id(), Keyword.t()) :: context_response(Tychron.M.Cart.t())
  def get_cart(cart_id, options \\ []) do
    http_request(:get, "/api/v1/carts/#{cart_id}", @no_query_params, @no_headers, nil, options)
    |> maybe_decode_response_document(%{
      200 => Tychron.M.Cart,
    })
  end
end
