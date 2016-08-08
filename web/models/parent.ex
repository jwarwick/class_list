defmodule ClassList.Parent do
  use ClassList.Web, :model

  schema "parents" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :mobile_phone, :string

    belongs_to :address, ClassList.Address

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:first_name, :last_name, :email, :mobile_phone, :address_id])
    |> validate_required([:first_name, :last_name])
    |> assoc_constraint(:address)
  end
end
