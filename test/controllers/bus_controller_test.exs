defmodule ClassList.BusControllerTest do
  use ClassList.ConnCase

  alias ClassList.Bus
  @valid_attrs %{name: "some content", order: 42}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, bus_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing buses"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, bus_path(conn, :new)
    assert html_response(conn, 200) =~ "New bus"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, bus_path(conn, :create), bus: @valid_attrs
    assert redirected_to(conn) == bus_path(conn, :index)
    assert Repo.get_by(Bus, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, bus_path(conn, :create), bus: @invalid_attrs
    assert html_response(conn, 200) =~ "New bus"
  end

  test "shows chosen resource", %{conn: conn} do
    bus = Repo.insert! %Bus{}
    conn = get conn, bus_path(conn, :show, bus)
    assert html_response(conn, 200) =~ "Show bus"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, bus_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    bus = Repo.insert! %Bus{}
    conn = get conn, bus_path(conn, :edit, bus)
    assert html_response(conn, 200) =~ "Edit bus"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    bus = Repo.insert! %Bus{}
    conn = put conn, bus_path(conn, :update, bus), bus: @valid_attrs
    assert redirected_to(conn) == bus_path(conn, :show, bus)
    assert Repo.get_by(Bus, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    bus = Repo.insert! %Bus{}
    conn = put conn, bus_path(conn, :update, bus), bus: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit bus"
  end

  test "deletes chosen resource", %{conn: conn} do
    bus = Repo.insert! %Bus{}
    conn = delete conn, bus_path(conn, :delete, bus)
    assert redirected_to(conn) == bus_path(conn, :index)
    refute Repo.get(Bus, bus.id)
  end
end
