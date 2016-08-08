defmodule ClassList.AddressTest do
  use ClassList.ModelCase

  alias ClassList.Address

  @valid_attrs %{address1: "some content", address2: "some content", city: "some content", phone: "some content", state: "some content", zip: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Address.changeset(%Address{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Address.changeset(%Address{}, @invalid_attrs)
    refute changeset.valid?
  end
end
