defmodule Tychron.M.SMS do
  use Tychron.SchemaBase

  @primary_key {:id, Ecto.ULID, autogenerate: true}

  embedded_schema do
    timestamps()

    field :expires_at, :utc_datetime_usec
    field :scheduled_at, :utc_datetime_usec
    field :sent_at, :utc_datetime_usec
    field :delivered_at, :utc_datetime_usec

    field :direction, :string
    field :from, :string
    field :to, :string
    field :type, :string

    field :body, :string
    field :encoding, :integer
    field :priority, :integer
    field :request_delivery_report, :string
    field :remote_service_provider, :string
    field :remote_reference_id, :string

    embeds_one :udh, UDH, primary_key: false do
      field :ref_num, :integer
      field :count, :integer
    end

    embeds_many :parts, Part, primary_key: {:id, Ecto.ULID, autogenerate: true} do
    end

    embeds_one :csp_campaign, CSPCampaign, primary_key: {:id, Ecto.UUID, autogenerate: true} do
      field :tcr_brand_id, :string
      field :tcr_campaign_id, :string
    end
  end

  @type t :: %__MODULE__{
    id: Ecto.ULID.t(),

    inserted_at: DateTime.t(),
    updated_at: DateTime.t(),
    expires_at: DateTime.t(),
    scheduled_at: DateTime.t(),
    sent_at: DateTime.t(),
    delivered_at: DateTime.t(),

    direction: String.t(),
    from: String.t(),
    to: String.t(),
    type: String.t(),

    body: String.t(),
    encoding: integer(),
    priority: integer(),
    request_delivery_report: String.t(),
    remote_service_provider: String.t(),
    remote_reference_id: String.t(),

    udh: %__MODULE__.UDH{
      ref_num: integer(),
      count: integer(),
    },

    parts: [
      %__MODULE__.Part{
        id: Ecto.ULID.t(),
      }
    ],

    csp_campaign: %__MODULE__.CSPCampaign{
      id: Ecto.UUID.t(),
      tcr_brand_id: String.t(),
      tcr_campaign_id: String.t(),
    }
  }
end
