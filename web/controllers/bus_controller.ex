defmodule ClassList.BusController do
  use ClassList.Web, :controller

  alias ClassList.Bus

  def index(conn, _params) do
    buses = Repo.all(Bus)
    render(conn, "index.html", buses: buses)
  end

  def new(conn, _params) do
    changeset = Bus.changeset(%Bus{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"bus" => bus_params}) do
    changeset = Bus.changeset(%Bus{}, bus_params)

    case Repo.insert(changeset) do
      {:ok, _bus} ->
        conn
        |> put_flash(:info, "Bus created successfully.")
        |> redirect(to: bus_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    bus = Repo.get!(Bus, id)
    render(conn, "show.html", bus: bus)
  end

  def edit(conn, %{"id" => id}) do
    bus = Repo.get!(Bus, id)
    changeset = Bus.changeset(bus)
    render(conn, "edit.html", bus: bus, changeset: changeset)
  end

  def update(conn, %{"id" => id, "bus" => bus_params}) do
    bus = Repo.get!(Bus, id)
    changeset = Bus.changeset(bus, bus_params)

    case Repo.update(changeset) do
      {:ok, bus} ->
        conn
        |> put_flash(:info, "Bus updated successfully.")
        |> redirect(to: bus_path(conn, :show, bus))
      {:error, changeset} ->
        render(conn, "edit.html", bus: bus, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    bus = Repo.get!(Bus, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(bus)

    conn
    |> put_flash(:info, "Bus deleted successfully.")
    |> redirect(to: bus_path(conn, :index))
  end
end
