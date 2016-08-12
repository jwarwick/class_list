defmodule ClassList.Student do
  use ClassList.Web, :model

  schema "students" do
    field :first_name, :string
    field :last_name, :string
    field :notes, :string

    belongs_to :bus, ClassList.Bus
    belongs_to :class, ClassList.Class

    many_to_many :parents, ClassList.Parent, join_through: "parents_students", on_replace: :delete, on_delete: :delete_all

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:first_name, :last_name, :notes, :bus_id, :class_id])
    |> validate_required([:first_name, :last_name])
    |> assoc_constraint(:bus)
    |> assoc_constraint(:class)
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  For use when converting an Entry, doesn't enforce required fields.
  """
  def entry_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:first_name, :last_name, :notes, :bus_id, :class_id])
    |> assoc_constraint(:bus)
    |> assoc_constraint(:class)
  end
end
