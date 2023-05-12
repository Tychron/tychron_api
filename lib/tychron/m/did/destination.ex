defmodule Tychron.M.DID.Destination do
  use Tychron.SchemaBase

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  embedded_schema do
    timestamps()

    field :activated, :boolean

    field :priority, :integer
    field :type, :string
    field :destination, :string

    field :auth_method, :string
    field :auth_identity, :string
    field :auth_secret, :string

    field :wait_time, :integer
  end

  @type t :: %__MODULE__{
    id: Ecto.UUID.t(),
    inserted_at: DateTime.t(),
    updated_at: DateTime.t(),
    activated: boolean(),

    priority: integer(),
    type: String.t(),
    destination: String.t(),

    auth_method: String.t(),
    auth_identity: String.t(),
    auth_secret: String.t(),

    wait_time: integer(),
  }
end
