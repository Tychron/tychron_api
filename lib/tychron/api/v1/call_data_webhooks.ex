defmodule Tychron.API.V1.CallDataWebhooks do
  use Tychron.API.HttpContextBase, endpoint_type: :api

  @type call_data_webhook_id :: Ecto.UUID.t()

  @spec create_call_data_webhook(map(), Keyword.t()) :: context_response(Tychron.M.CallDataWebhook.t())
  def create_call_data_webhook(params, options \\ []) do
    doc = to_req_document(params, "call_data_webhook")
    http_request(:post, "/api/v1/call_data_webhooks", @no_query_params, @no_headers, {:json, doc}, options)
    |> maybe_decode_response_document(%{
      201 => Tychron.M.CallDataWebhook,
    })
  end

  @spec update_call_data_webhook(call_data_webhook_id(), map(), Keyword.t()) :: context_response(Tychron.M.CallDataWebhook.t())
  def update_call_data_webhook(call_data_webhook_id, params, options \\ []) do
    doc = to_req_document(params, "call_data_webhook")
    http_request(
      :patch,
      "/api/v1/call_data_webhooks/#{call_data_webhook_id}",
      @no_query_params,
      @no_headers,
      {:json, doc},
      options
    )
    |> maybe_decode_response_document(%{
      200 => Tychron.M.CallDataWebhook,
    })
  end

  @spec delete_call_data_webhook(call_data_webhook_id(), map(), Keyword.t()) :: context_response(Tychron.M.CallDataWebhook.t())
  def delete_call_data_webhook(call_data_webhook_id, query_params, options \\ []) do
    http_request(
      :delete,
      "/api/v1/call_data_webhooks/#{call_data_webhook_id}",
      query_params,
      @no_headers,
      nil,
      options
    )
    |> maybe_decode_response_document(%{
      200 => Tychron.M.CallDataWebhook,
    })
  end

  @spec checkout_call_data_webhook(call_data_webhook_id(), Keyword.t()) :: context_response(Tychron.M.Order.t())
  def checkout_call_data_webhook(call_data_webhook_id, options \\ []) do
    http_request(
      :post,
      "/api/v1/call_data_webhooks/#{call_data_webhook_id}/checkout",
      @no_query_params,
      @no_headers,
      nil,
      options
    )
    |> maybe_decode_response_document(%{
      200 => Tychron.M.Order,
    })
  end

  @spec list_call_data_webhooks(map(), Keyword.t()) :: context_page_response(Tychron.M.CallDataWebhook.t())
  def list_call_data_webhooks(query_params, options \\ []) do
    http_request(:get, "/api/v1/call_data_webhooks", query_params, @no_headers, nil, options)
    |> maybe_decode_response_page(%{
      200 => Tychron.M.CallDataWebhook,
    })
  end

  @spec get_call_data_webhook(call_data_webhook_id(), Keyword.t()) :: context_response(Tychron.M.CallDataWebhook.t())
  def get_call_data_webhook(call_data_webhook_id, options \\ []) do
    http_request(
      :get,
      "/api/v1/call_data_webhooks/#{call_data_webhook_id}",
      @no_query_params,
      @no_headers,
      nil,
      options
    )
    |> maybe_decode_response_document(%{
      200 => Tychron.M.CallDataWebhook,
    })
  end
end
