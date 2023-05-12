defmodule Tychron.M.DID do
  use Tychron.SchemaBase

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  embedded_schema do
    timestamps()

    field :activated, :boolean
    field :description, :string
    field :forward_number, :string
    field :help_message, :string
    field :message_class, :string

    field :mms_enabled, :boolean
    field :sms_enabled, :boolean
    field :voice_enabled, :boolean

    field :number, :string

    field :segment_threshold, :integer
    embeds_many :segment_overrides, SegmentOverride, primary_key: {:id, Ecto.UUID, autogenerate: true} do
      field :encoding, :integer
      field :segment_threshold, :integer
      field :target_reference_id, :string
    end

    field :tier, :string
    field :state, :string
    field :rate_center, :string

    field :upgrade_asset_handling, :string
  end

  @type t :: %__MODULE__{
    id: Ecto.UUID.t(),
    inserted_at: DateTime.t(),
    updated_at: DateTime.t(),
    activated: boolean(),
    number: String.t(),
  }
end
