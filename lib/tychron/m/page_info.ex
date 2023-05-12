defmodule Tychron.M.PageInfo do
  use Tychron.SchemaBase

  @primary_key false

  embedded_schema do
    field :start_cursor, :string
    field :end_cursor, :string
    field :has_next_page, :boolean
    field :has_previous_page, :boolean
  end

  @type t :: %__MODULE__{
    start_cursor: String.t(),
    end_cursor: String.t(),
    has_next_page: boolean(),
    has_previous_page: boolean(),
  }
end
