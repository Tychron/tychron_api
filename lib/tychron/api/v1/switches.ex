defmodule Tychron.API.V1.Switches do
  use Tychron.API.HttpContextBase

  @type switch_id :: Ecto.UUID.t()

  @spec create_switch(map(), Keyword.t()) :: context_response(Tychron.M.Switch.t())
  def create_switch(params, options \\ []) do
    doc = to_req_document(params, "switch")
    http_request(:post, "/api/v1/switches", @no_query_params, @no_headers, {:json, doc}, options)
    |> maybe_decode_response_document(%{
      201 => Tychron.M.Switch,
    })
  end

  @spec update_switch(switch_id(), map(), Keyword.t()) :: context_response(Tychron.M.Switch.t())
  def update_switch(switch_id, params, options \\ []) do
    doc = to_req_document(params, "switch")
    http_request(:patch, "/api/v1/switches/#{switch_id}", @no_query_params, @no_headers, {:json, doc}, options)
    |> maybe_decode_response_document(%{
      200 => Tychron.M.Switch,
    })
  end

  @spec delete_switch(switch_id(), map(), Keyword.t()) :: context_response(Tychron.M.Switch.t())
  def delete_switch(switch_id, query_params, options \\ []) do
    http_request(:delete, "/api/v1/switches/#{switch_id}", query_params, @no_headers, nil, options)
    |> maybe_decode_response_document(%{
      200 => Tychron.M.Switch,
    })
  end

  @spec list_switches(map(), Keyword.t()) :: context_page_response(Tychron.M.Switch.t())
  def list_switches(query_params, options \\ []) do
    http_request(:get, "/api/v1/switches", query_params, @no_headers, nil, options)
    |> maybe_decode_response_page(%{
      200 => Tychron.M.Switch,
    })
  end

  @spec get_switch(switch_id(), Keyword.t()) :: context_response(Tychron.M.Switch.t())
  def get_switch(switch_id, options \\ []) do
    http_request(:get, "/api/v1/switches/#{switch_id}", @no_query_params, @no_headers, nil, options)
    |> maybe_decode_response_document(%{
      200 => Tychron.M.Switch,
    })
  end
end
