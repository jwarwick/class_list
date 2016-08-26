defmodule ClassList.Bus do
  @moduledoc """
  Bus with student riders
  """
  use ClassList.Web, :model

  schema "buses" do
    field :name, :string
    field :order, :integer
    field :should_display, :boolean

    has_many :students, ClassList.Student, on_delete: :nilify_all

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :order, :should_display])
    |> validate_required([:name, :order, :should_display])
  end

  @doc """
  Return items sorted by `order` field
  """
  def sorted(query) do
    from p in query,
    order_by: :order
  end
end
