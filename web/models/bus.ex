defmodule ClassList.Bus do
  use ClassList.Web, :model

  schema "buses" do
    field :name, :string
    field :order, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :order])
    |> validate_required([:name, :order])
  end
end
