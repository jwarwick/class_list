defmodule ClassList.ClassController do
  use ClassList.Web, :controller

  alias ClassList.Class
  alias ClassList.Student

  def index(conn, _params) do
    classes = Class |> Class.sorted |> Repo.all
    render(conn, "index.html", classes: classes)
  end

  def new(conn, _params) do
    changeset = Class.changeset(%Class{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"class" => class_params}) do
    changeset = Class.changeset(%Class{}, class_params)

    case Repo.insert(changeset) do
      {:ok, _class} ->
        conn
        |> put_flash(:info, "Class created successfully.")
        |> redirect(to: class_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    class = Class |> Repo.get!(id) |> Repo.preload(:students)
    render(conn, "show.html", class: class)
  end

  def edit(conn, %{"id" => id}) do
    class = Repo.get!(Class, id)
    changeset = Class.changeset(class)
    render(conn, "edit.html", class: class, changeset: changeset)
  end

  def update(conn, %{"id" => id, "class" => class_params}) do
    class = Repo.get!(Class, id)
    changeset = Class.changeset(class, class_params)

    case Repo.update(changeset) do
      {:ok, class} ->
        conn
        |> put_flash(:info, "Class updated successfully.")
        |> redirect(to: class_path(conn, :show, class))
      {:error, changeset} ->
        render(conn, "edit.html", class: class, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    class = Repo.get!(Class, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(class)

    conn
    |> put_flash(:info, "Class deleted successfully.")
    |> redirect(to: class_path(conn, :index))
  end

  def list(conn, _params) do
    classes = Class
              |> Class.sorted
              |> Repo.all
              |> Repo.preload([students: from(Student, order_by: [:last_name])])
    render(conn, "list.html", classes: classes)
  end
end
