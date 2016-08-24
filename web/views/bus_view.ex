defmodule ClassList.BusView do
  use ClassList.Web, :view
  @dialyzer :no_match
  alias ClassList.Bus
  alias ClassList.Repo

  def bus_count, do: Repo.aggregate(Bus, :count, :id)
end
