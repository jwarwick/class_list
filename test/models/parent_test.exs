defmodule ClassList.ParentTest do
  use ClassList.ModelCase

  alias ClassList.Parent

  @valid_attrs %{email: "some content", first_name: "some content", last_name: "some content", mobile_phone: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Parent.changeset(%Parent{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Parent.changeset(%Parent{}, @invalid_attrs)
    refute changeset.valid?
  end
end
