defmodule Tychron.M.Cart.Request do
  use Tychron.SchemaBase

  @primary_key {:id, Ecto.ULID, autogenerate: true}

  embedded_schema do
    timestamps()

    field :name, :string
    field :notes, :string

    field :type, :string

    # So anything that doesn't match the above fields gets moved into this field
    field :data, :map
  end

  @type t :: %__MODULE__{
    id: Ecto.ULID.t(),
    inserted_at: DateTime.t(),
    updated_at: DateTime.t(),
    name: String.t(),
    notes: String.t(),
    data: map(),
  }
end
