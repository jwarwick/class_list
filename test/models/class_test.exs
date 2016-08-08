defmodule ClassList.ClassTest do
  use ClassList.ModelCase

  alias ClassList.Class

  @valid_attrs %{name: "some content", order: 42, teacher: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Class.changeset(%Class{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Class.changeset(%Class{}, @invalid_attrs)
    refute changeset.valid?
  end
end
