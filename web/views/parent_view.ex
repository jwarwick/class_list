defmodule ClassList.ParentView do
  use ClassList.Web, :view
  alias ClassList.Address
  alias ClassList.Student
  alias ClassList.Repo

  def address_select_list do
    Repo.all(Address)
    |> Enum.map(fn address -> {address.address1, address.id} end)
  end

  def student_select_list do
    Repo.all(Student)
    |> Enum.map(fn student -> {"#{student.last_name}, #{student.first_name}", student.id} end)
  end
end
