defmodule Tychron.API.V1 do
  alias Tychron.API.V1.Carts
  alias Tychron.API.V1.Cart.Requests, as: CartRequests
  alias Tychron.API.V1.Orders
  alias Tychron.API.V1.Requests
  alias Tychron.API.V1.Users
  alias Tychron.API.V1.ApiKeys
  alias Tychron.API.V1.Switches
  alias Tychron.API.V1.BulkDipTasks

  #
  # Carts
  #
  defdelegate create_cart(params, options \\ []), to: Carts
  defdelegate update_cart(cart_id, params, options \\ []), to: Carts
  defdelegate delete_cart(cart_id, options \\ []), to: Carts
  defdelegate checkout_cart(cart_id, options \\ []), to: Carts
  defdelegate list_carts(query_params, options \\ []), to: Carts
  defdelegate get_cart(cart_id, options \\ []), to: Carts

  #
  # Cart Requests
  #
  defdelegate create_cart_request(cart_id, params, options \\ []), to: CartRequests
  defdelegate update_cart_request(cart_id, request_id, params, options \\ []), to: CartRequests
  defdelegate delete_cart_request(cart_id, request_id, options \\ []), to: CartRequests
  defdelegate list_cart_requests(cart_id, query_params, options \\ []), to: CartRequests
  defdelegate get_cart_request(cart_id, request_id, options \\ []), to: CartRequests

  #
  # Orders
  #
  defdelegate update_order(order_id, params, options \\ []), to: Orders
  defdelegate list_orders(query_params, options \\ []), to: Orders
  defdelegate get_order(order_id, options \\ []), to: Orders

  #
  # Requests
  #
  defdelegate update_request(request_id, params, options \\ []), to: Requests
  defdelegate list_requests(query_params, options \\ []), to: Requests
  defdelegate get_request(request_id, options \\ []), to: Requests

  #
  # Users
  #
  defdelegate create_user(params, options \\ []), to: Users
  defdelegate update_user(user_id, params, options \\ []), to: Users
  defdelegate delete_user(user_id, options \\ []), to: Users
  defdelegate list_users(query_params, options \\ []), to: Users
  defdelegate get_user(user_id, options \\ []), to: Users

  #
  # API Keys
  #
  defdelegate create_api_key(params, options \\ []), to: ApiKeys
  defdelegate update_api_key(api_key_id, params, options \\ []), to: ApiKeys
  defdelegate delete_api_key(api_key_id, options \\ []), to: ApiKeys
  defdelegate list_api_keys(query_params, options \\ []), to: ApiKeys
  defdelegate get_api_key(api_key_id, options \\ []), to: ApiKeys

  #
  # Switches
  #
  defdelegate create_switch(params, options \\ []), to: Switches
  defdelegate update_switch(switch_id, params, options \\ []), to: Switches
  defdelegate delete_switch(switch_id, options \\ []), to: Switches
  defdelegate list_switches(query_params, options \\ []), to: Switches
  defdelegate get_switch(switch_id, options \\ []), to: Switches

  #
  # Bulk Dip Tasks
  #
  defdelegate create_bulk_dip_task(params, options \\ []), to: BulkDipTasks
  defdelegate list_bulk_dip_tasks(query_params, options \\ []), to: BulkDipTasks
  defdelegate get_bulk_dip_task(bulk_dip_task_id, options \\ []), to: BulkDipTasks
end
