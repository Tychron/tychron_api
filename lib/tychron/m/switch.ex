defmodule Tychron.M.Switch do
  use Tychron.SchemaBase

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  embedded_schema do
    timestamps()

    field :name, :string

    field :mms_enabled, :boolean
    field :mms_protocol, :string
    field :mms_data, :string
    field :mms_message_format, :string
    #
    field :mms_auth_method, :string
    field :mms_auth_name, :string
    field :mms_auth_identity, :string
    field :mms_auth_secret, :string
    embeds_one :mms_options, MMSOptions, primary_key: false do
      field :dlr_on_sent, :boolean
      field :forward_dlr, :boolean
      field :pad_shortcodes, :boolean
    end

    field :sms_enabled, :boolean
    field :sms_protocol, :string
    field :sms_data, :string
    field :sms_message_format, :string
    #
    field :sms_auth_method, :string
    field :sms_auth_name, :string
    field :sms_auth_identity, :string
    field :sms_auth_secret, :string
    embeds_one :sms_options, SMSOptions, primary_key: false do
      field :dlr_on_sent, :boolean
      field :forward_dlr, :boolean
      field :pad_shortcodes, :boolean
    end

    field :voice_enabled, :boolean
    field :voice_protocol, :string
    field :voice_data, :string
    #
    field :voice_auth_method, :string
    field :voice_auth_name, :string
    field :voice_auth_identity, :string
    field :voice_auth_secret, :string
  end

  @type t :: %__MODULE__{
    id: Ecto.ULID.t(),
    inserted_at: DateTime.t(),
    updated_at: DateTime.t(),
    name: String.t(),
    #
    mms_enabled: boolean(),
    mms_protocol: String.t(),
    mms_data: String.t(),
    mms_message_format: String.t(),
    mms_auth_method: String.t(),
    mms_auth_name: String.t(),
    mms_auth_identity: String.t(),
    mms_auth_secret: String.t(),
    mms_options: map(),
    #
    sms_enabled: boolean(),
    sms_protocol: String.t(),
    sms_data: String.t(),
    sms_message_format: String.t(),
    sms_auth_method: String.t(),
    sms_auth_name: String.t(),
    sms_auth_identity: String.t(),
    sms_auth_secret: String.t(),
    sms_options: map(),
    #
    voice_enabled: boolean(),
    voice_protocol: String.t(),
    voice_data: String.t(),
    voice_auth_method: String.t(),
    voice_auth_name: String.t(),
    voice_auth_identity: String.t(),
    voice_auth_secret: String.t(),
  }
end
