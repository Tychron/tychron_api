defmodule Tychron.M.Cart do
  use Tychron.SchemaBase

  @primary_key {:id, Ecto.ULID, autogenerate: true}

  embedded_schema do
    timestamps()

    field :name, :string
    field :notes, :string
  end

  @type t :: %__MODULE__{
    id: Ecto.ULID.t(),
    inserted_at: DateTime.t(),
    updated_at: DateTime.t(),
    name: String.t(),
    notes: String.t(),
  }
end
