defmodule Tychron.M.DocumentResponseError do
  defstruct [
    :response,
    :response_data,
    :document,
    :errors,
  ]
end
