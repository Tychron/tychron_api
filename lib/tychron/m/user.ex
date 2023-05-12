defmodule Tychron.M.User do
  defmodule Address do
    use Tychron.SchemaBase

    embedded_schema do
      field :address1, :string
      field :address2, :string
      field :business_name, :string
      field :city, :string
      field :country, :string
      field :email, :string
      field :fax_number, :string
      field :first_name, :string
      field :last_name, :string
      field :house_number, :string
      field :notes, :string
      field :phone_number, :string
      field :state, :string
      field :zip_code, :string
    end
  end

  use Tychron.SchemaBase

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  embedded_schema do
    timestamps()

    field :first_name, :string
    field :last_name, :string
    field :title, :string
    field :email, :string

    embeds_one :address, Address
  end

  @type t :: %__MODULE__{
    id: Ecto.UUID.t(),
    inserted_at: DateTime.t(),
    updated_at: DateTime.t(),
    first_name: String.t(),
    last_name: String.t(),
    title: String.t(),
    email: String.t(),
  }
end
