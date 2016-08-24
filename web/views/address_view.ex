defmodule ClassList.AddressView do
  use ClassList.Web, :view
  @dialyzer :no_match
  alias ClassList.Address
  alias ClassList.Repo

  def address_count, do: Repo.aggregate(Address, :count, :id)
end
