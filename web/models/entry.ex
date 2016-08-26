defmodule ClassList.Entry do
  @moduledoc """
  The raw map fields captured by the Entry controller
  """
  use ClassList.Web, :model

  schema "entries" do
    field :data, :binary

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:data])
    |> validate_required([:data])
  end
end
