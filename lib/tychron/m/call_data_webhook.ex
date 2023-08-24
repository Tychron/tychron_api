defmodule Tychron.M.CallDataWebhook do
  defmodule CustomHeader do
    use Tychron.SchemaBase

    embedded_schema do
      field :key, :string
      field :value, :string
    end
  end

  defmodule CustomQueryParam do
    use Tychron.SchemaBase

    embedded_schema do
      field :key, :string
      field :value, :string
    end
  end

  use Tychron.SchemaBase

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  embedded_schema do
    timestamps()

    field :name, :string
    field :notes, :string

    field :protocol, :string
    field :data, :string

    field :auth_method, :string
    field :auth_identity, :string
    field :auth_secret, :string

    embeds_many :custom_headers, CustomHeader
    embeds_many :custom_query_params, CustomQueryParam
  end

  @type t :: %__MODULE__{
    id: Ecto.UUID.t(),
    inserted_at: DateTime.t(),
    updated_at: DateTime.t(),
    name: String.t(),
    notes: String.t(),
    auth_method: String.t(),
    auth_identity: String.t(),
    auth_secret: String.t(),
    custom_headers: [CustomHeader.t()],
    custom_query_params: [CustomQueryParam.t()],
  }
end
