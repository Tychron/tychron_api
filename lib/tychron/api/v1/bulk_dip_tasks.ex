defmodule Tychron.API.V1.BulkDipTasks do
  use Tychron.API.HttpContextBase

  @type bulk_dip_task_id :: Ecto.UUID.t()

  @spec create_bulk_dip_task(map(), Keyword.t()) :: context_response(Tychron.M.BulkDipTask.t())
  def create_bulk_dip_task(params, options \\ []) do
    doc = to_req_document(params, "bulk_dip_task")
    http_request(:post, "/api/v1/bulk_dip_tasks", @no_query_params, @no_headers, {:json, doc}, options)
    |> maybe_decode_response_document(%{
      201 => Tychron.M.BulkDipTask,
    })
  end

  @spec list_bulk_dip_tasks(map(), Keyword.t()) :: context_page_response(Tychron.M.BulkDipTask.t())
  def list_bulk_dip_tasks(query_params, options \\ []) do
    http_request(:get, "/api/v1/bulk_dip_tasks", query_params, @no_headers, nil, options)
    |> maybe_decode_response_page(%{
      200 => Tychron.M.BulkDipTask,
    })
  end

  @spec get_bulk_dip_task(bulk_dip_task_id(), Keyword.t()) :: context_response(Tychron.M.BulkDipTask.t())
  def get_bulk_dip_task(bulk_dip_task_id, options \\ []) do
    http_request(:get, "/api/v1/bulk_dip_tasks/#{bulk_dip_task_id}", @no_query_params, @no_headers, nil, options)
    |> maybe_decode_response_document(%{
      200 => Tychron.M.BulkDipTask,
    })
  end
end
