defmodule Tychron.API.V1.Users do
  use Tychron.API.HttpContextBase

  @type user_id :: Ecto.UUID.t()

  @spec create_user(map(), Keyword.t()) :: context_response(Tychron.M.User.t())
  def create_user(params, options \\ []) do
    doc = to_req_document(params, "user")
    http_request(:post, "/api/v1/users", @no_query_params, @no_headers, {:json, doc}, options)
    |> maybe_decode_response_document(%{
      201 => Tychron.M.User,
    })
  end

  @spec update_user(user_id(), map(), Keyword.t()) :: context_response(Tychron.M.User.t())
  def update_user(user_id, params, options \\ []) do
    doc = to_req_document(params, "user")
    http_request(:patch, "/api/v1/users/#{user_id}", @no_query_params, @no_headers, {:json, doc}, options)
    |> maybe_decode_response_document(%{
      200 => Tychron.M.User,
    })
  end

  @spec delete_user(user_id(), map(), Keyword.t()) :: context_response(Tychron.M.User.t())
  def delete_user(user_id, query_params, options \\ []) do
    http_request(:delete, "/api/v1/users/#{user_id}", query_params, @no_headers, nil, options)
    |> maybe_decode_response_document(%{
      200 => Tychron.M.User,
    })
  end

  @spec list_users(map(), Keyword.t()) :: context_page_response(Tychron.M.User.t())
  def list_users(query_params, options \\ []) do
    http_request(:get, "/api/v1/users", query_params, @no_headers, nil, options)
    |> maybe_decode_response_page(%{
      200 => Tychron.M.User,
    })
  end

  @spec get_user(user_id(), Keyword.t()) :: context_response(Tychron.M.User.t())
  def get_user(user_id, options \\ []) do
    http_request(:get, "/api/v1/users/#{user_id}", @no_query_params, @no_headers, nil, options)
    |> maybe_decode_response_document(%{
      200 => Tychron.M.User,
    })
  end
end
