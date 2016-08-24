defmodule ClassList.DirectoryView do
  use ClassList.Web, :view
  @dialyzer :no_match
  alias ClassList.Repo

  def preload_student(student) do
    Repo.preload(student, [:bus, parents: :address])
  end

  # [{[p1, p2], address1}, {[p3, p4], address2}]
  def group_parents(student) do
    student.parents
    |> Enum.group_by(&(&1.address_id))
    |> Enum.map(fn({_, parent_list}) -> {parent_list, List.first(parent_list).address} end)
  end

  def not_empty(nil), do: false
  def not_empty(str) do
    length = str |> String.trim |> String.length
    0 != length
  end
end
