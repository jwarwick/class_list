defmodule ClassList.ParentControllerTest do
  use ClassList.ConnCase

  alias ClassList.Parent
  @valid_attrs %{email: "some content", first_name: "some content", last_name: "some content", mobile_phone: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, parent_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing parents"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, parent_path(conn, :new)
    assert html_response(conn, 200) =~ "New parent"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, parent_path(conn, :create), parent: @valid_attrs
    assert redirected_to(conn) == parent_path(conn, :index)
    assert Repo.get_by(Parent, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, parent_path(conn, :create), parent: @invalid_attrs
    assert html_response(conn, 200) =~ "New parent"
  end

  test "shows chosen resource", %{conn: conn} do
    parent = Repo.insert! %Parent{}
    conn = get conn, parent_path(conn, :show, parent)
    assert html_response(conn, 200) =~ "Show parent"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, parent_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    parent = Repo.insert! %Parent{}
    conn = get conn, parent_path(conn, :edit, parent)
    assert html_response(conn, 200) =~ "Edit parent"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    parent = Repo.insert! %Parent{}
    conn = put conn, parent_path(conn, :update, parent), parent: @valid_attrs
    assert redirected_to(conn) == parent_path(conn, :show, parent)
    assert Repo.get_by(Parent, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    parent = Repo.insert! %Parent{}
    conn = put conn, parent_path(conn, :update, parent), parent: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit parent"
  end

  test "deletes chosen resource", %{conn: conn} do
    parent = Repo.insert! %Parent{}
    conn = delete conn, parent_path(conn, :delete, parent)
    assert redirected_to(conn) == parent_path(conn, :index)
    refute Repo.get(Parent, parent.id)
  end
end
