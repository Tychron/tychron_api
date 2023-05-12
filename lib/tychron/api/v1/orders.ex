defmodule Tychron.API.V1.Orders do
  use Tychron.API.HttpContextBase

  @type order_id :: Ecto.ULID.t()

  @spec update_order(order_id(), map(), Keyword.t()) :: context_response(Tychron.M.Order.t())
  def update_order(order_id, params, options \\ []) do
    doc = to_req_document(params, "order")
    http_request(:patch, "/api/v1/orders/#{order_id}", @no_query_params, @no_headers, {:json, doc}, options)
    |> maybe_decode_response_document(%{
      200 => Tychron.M.Order,
    })
  end

  @spec list_orders(map(), Keyword.t()) :: context_page_response(Tychron.M.Order.t())
  def list_orders(query_params, options \\ []) do
    http_request(:get, "/api/v1/orders", query_params, @no_headers, nil, options)
    |> maybe_decode_response_page(%{
      200 => Tychron.M.Order,
    })
  end

  @spec get_order(order_id(), Keyword.t()) :: context_response(Tychron.M.Order.t())
  def get_order(order_id, options \\ []) do
    http_request(:get, "/api/v1/orders/#{order_id}", @no_query_params, @no_headers, nil, options)
    |> maybe_decode_response_document(%{
      200 => Tychron.M.Order,
    })
  end
end
