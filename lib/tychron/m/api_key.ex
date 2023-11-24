defmodule Tychron.M.ApiKey do
  use Tychron.SchemaBase

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  embedded_schema do
    timestamps()

    field :active, :boolean

    field :name, :string
    field :notes, :string

    field :identity, :string
    field :secret, :string
    field :key, :string
    field :smpp_system_id, :string
    field :smpp_secret, :string
  end

  @type t :: %__MODULE__{
    id: Ecto.UUID.t(),
    inserted_at: DateTime.t(),
    updated_at: DateTime.t(),
    name: String.t(),
    notes: String.t(),
    identity: String.t(),
    secret: String.t(),
    key: String.t(),
    smpp_system_id: String.t(),
    smpp_secret: String.t(),
  }
end
