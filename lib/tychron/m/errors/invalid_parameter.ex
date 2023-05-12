defmodule Tychron.M.Errors.InvalidParameter do
  use Tychron.SchemaBase

  @primary_key false

  embedded_schema do
    field :code, :string
    field :sub_code, :string
    field :title, :string
    field :detail, :string
    embeds_one :source, Source do
      field :in, :string
      field :pointer, :string
    end
  end
end
