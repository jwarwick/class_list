defmodule ClassList.Class do
  use ClassList.Web, :model

  schema "classes" do
    field :name, :string
    field :teacher, :string
    field :order, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :teacher, :order])
    |> validate_required([:name, :teacher, :order])
  end
end
