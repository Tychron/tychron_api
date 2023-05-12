defmodule Tychron.M.PageResult do
  use Tychron.SchemaBase

  @primary_key false

  embedded_schema do
    embeds_many :results, Tychron.M.Document
    field :count, :integer
    embeds_one :page_info, Tychron.M.PageInfo
  end

  @type t :: %__MODULE__{
    results: [any()],
    count: integer(),
    page_info: Tychron.API.PageInfo.t(),
  }
end
