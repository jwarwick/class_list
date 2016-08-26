defmodule ClassList.EntryView do
  use ClassList.Web, :view
  @dialyzer :no_match
  alias ClassList.Bus
  alias ClassList.Class
  alias ClassList.Entry
  alias ClassList.Repo

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
    |> Enum.map(fn class -> {"#{class.name}, #{class.teacher}", class.id} end)
  end

  def entry_count, do: Repo.aggregate(Entry, :count, :id)
end
