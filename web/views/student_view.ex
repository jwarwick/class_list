defmodule ClassList.StudentView do
  use ClassList.Web, :view
  @dialyzer :no_match
  alias ClassList.Bus
  alias ClassList.Class
  alias ClassList.Repo
  alias ClassList.Student

  def bus_select_list do
    Bus
    |> Bus.sorted
    |> Repo.all
    |> Enum.map(fn bus -> {bus.name, bus.id} end)
  end

  def class_select_list do
    Class
    |> Class.sorted
    |> Repo.all
    |> Enum.map(fn class -> {class.name, class.id} end)
  end

  def student_count, do: Repo.aggregate(Student, :count, :id)
end
