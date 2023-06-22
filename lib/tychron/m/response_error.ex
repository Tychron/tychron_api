defmodule Tychron.M.ResponseError do
  defstruct [
    :response,
    :response_data,
    :document,
    :errors,
  ]
end
