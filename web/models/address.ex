defmodule ClassList.Address do
  use ClassList.Web, :model

  schema "addresses" do
    field :address1, :string
    field :address2, :string
    field :city, :string
    field :state, :string
    field :zip, :string
    field :phone, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:address1, :address2, :city, :state, :zip, :phone])
    |> validate_required([:address1, :city, :state, :zip])
  end
end
