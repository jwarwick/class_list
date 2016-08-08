defmodule ClassList.ParentView do
  use ClassList.Web, :view
  alias ClassList.Address
  alias ClassList.Repo

  def address_select_list do
    Repo.all(Address)
    |> Enum.map(fn address -> {address.address1, address.id} end)
  end
end
