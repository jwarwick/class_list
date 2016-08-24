defmodule ClassList.ClassView do
  use ClassList.Web, :view
  @dialyzer :no_match
  alias ClassList.Class
  alias ClassList.Repo

  def class_count, do: Repo.aggregate(Class, :count, :id)
end
