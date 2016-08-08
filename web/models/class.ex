defmodule ClassList.Class do
  use ClassList.Web, :model

  schema "classes" do
    field :name, :string
    field :teacher, :string
    field :order, :integer

    has_many :students, ClassList.Student, on_delete: :nilify_all

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

  @doc """
  Return items sorted by `order` field
  """
  def sorted(query) do
    from p in query,
    order_by: :order
  end
end
