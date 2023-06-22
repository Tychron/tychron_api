defmodule Tychron.API.V1.SMSES do
  use Tychron.API.HttpContextBase, endpoint_type: :sms

  def send_sms(doc, options \\ []) do
    http_request(:post, "/sms", @no_query_params, @no_headers, {:json, doc}, options)
    |> maybe_decode_sms_response()
  end

  defp maybe_decode_sms_response({:ok, %{status_code: 200} = response, {:json, doc} = response_data}) do
    smses =
      Enum.map(doc, fn {_recipient, entry} ->
        Ecto.embedded_load(Tychron.M.SMS, entry, :json)
      end)

    {:ok, %Tychron.M.SendSMSResponse{
      response: response,
      response_data: response_data,
      smses: smses,
    }}
  end

  defp maybe_decode_sms_response({:ok, %{status_code: 422} = response, {:json, doc} = response_data}) do
    %{
      "errors" => errors,
    } = doc

    errors =
      Enum.map(errors, fn %{"code" => "invalid_parameter"} = error ->
        Ecto.embedded_load(Tychron.M.Errors.InvalidParameter, error, :json)
      end)

    {:error, %Tychron.M.DocumentResponseError{
      response: response,
      response_data: response_data,
      document: nil,
      errors: errors,
    }}
  end
end
