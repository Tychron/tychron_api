defmodule Tychron.M.SendSMSResponse do
  defstruct [
    :response,
    :response_data,
    :smses,
  ]

  @type t :: %__MODULE__{
    response: HTTPoison.Response.t(),
    response_data: {:json, any()},
    smses: [Tychron.M.SMS.t()],
  }
end
