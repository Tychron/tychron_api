defmodule Tychron.M.Order do
  use Tychron.SchemaBase

  @primary_key {:id, Ecto.ULID, autogenerate: true}

  embedded_schema do
    timestamps()

    field :name, :string
    field :notes, :string

    field :status, :string
    field :error_code, :string
  end

  @type t :: %__MODULE__{
    id: Ecto.ULID.t(),
    inserted_at: DateTime.t(),
    updated_at: DateTime.t(),
    name: String.t(),
    notes: String.t(),
    status: String.t(),
    error_code: String.t(),
  }
end
