defmodule Tychron.M.BulkDipTask do
  use Tychron.SchemaBase

  @primary_key {:id, Ecto.ULID, autogenerate: true}

  embedded_schema do
    timestamps()

    field :done_at, :utc_datetime_usec

    field :enhanced, :boolean
    field :messaging_lookup, :boolean

    field :reference_id, :string

    field :type, :string

    field :format, :string

    field :numbers, {:array, :string}

    field :status, :string
    field :error_code, :string

    embeds_many :on_done_actions, OnDoneAction do
      field :protocol, :string
      field :data, :string

      field :type, :string
      field :filename, :string
      field :archive_format, :string

      field :status, :string
      field :error_code, :string

      field :auth_method, :string
      field :auth_identity, :string
      field :auth_secret, :string
    end
  end

  @type t :: %__MODULE__{
    id: Ecto.ULID.t(),
    inserted_at: DateTime.t(),
    updated_at: DateTime.t(),
    done_at: DateTime.t(),
    enhanced: boolean(),
    messaging_lookup: boolean(),

    reference_id: String.t(),

    type: String.t(),
    format: String.t(),

    numbers: [String.t()],

    status: String.t(),
    error_code: String.t(),
  }
end
