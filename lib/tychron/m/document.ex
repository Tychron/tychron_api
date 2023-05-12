defmodule Tychron.M.Document do
  use Tychron.SchemaBase

  @primary_key false

  embedded_schema do
    field :type, :string
    field :data, :map
    field :associations, :map
  end

  @type t(data_t) :: %__MODULE__{
    type: String.t(),
    data: data_t,
    associations: map(),
  }
end
