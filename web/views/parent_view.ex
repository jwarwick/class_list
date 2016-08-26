defmodule ClassList.ParentView do
  use ClassList.Web, :view
  @dialyzer :no_match
  require Ecto.Query
  alias Ecto.Query
  alias ClassList.Address
  alias ClassList.Student
  alias ClassList.Parent
  alias ClassList.Repo

  def address_select_list do
    Address
    |> Query.order_by(:address1)
    |> Repo.all
    |> Enum.map(fn address -> {address.address1, address.id} end)
  end

  def student_select_list do
    Student
    |> Query.order_by([:last_name, :first_name])
    |> Repo.all
    |> Enum.map(fn student ->
                 {"#{student.last_name}, #{student.first_name}", student.id}
                end)
  end

  def parent_count, do: Repo.aggregate(Parent, :count, :id)
end
