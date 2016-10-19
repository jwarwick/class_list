defmodule ClassList.ParentController do
  use ClassList.Web, :controller

  alias ClassList.Parent

  def index(conn, _params) do
    parents = Parent |> order_by([:last_name, :first_name]) |> Repo.all
    render(conn, "index.html", parents: parents)
  end

  def new(conn, _params) do
    changeset = Parent.changeset(%Parent{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"parent" => parent_params}) do
    changeset = Parent.changeset(%Parent{}, parent_params)

    case Repo.insert(changeset) do
      {:ok, _parent} ->
        conn
        |> put_flash(:info, "Parent created successfully.")
        |> redirect(to: parent_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    parent = Parent |> Repo.get!(id) |> Repo.preload([:address, :students])
    render(conn, "show.html", parent: parent)
  end

  def edit(conn, %{"id" => id}) do
    parent = Parent |> Repo.get!(id) |> Repo.preload(:students)
    changeset = Parent.changeset(parent)
    render(conn, "edit.html", parent: parent, changeset: changeset)
  end

  def update(conn, %{"id" => id, "parent" => parent_params}) do
    parent = Parent |> Repo.get!(id) |> Repo.preload(:students)
    changeset = Parent.changeset(parent, parent_params)

    case Repo.update(changeset) do
      {:ok, parent} ->
        conn
        |> put_flash(:info, "Parent updated successfully.")
        |> redirect(to: parent_path(conn, :show, parent))
      {:error, changeset} ->
        render(conn, "edit.html", parent: parent, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    parent = Repo.get!(Parent, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(parent)

    conn
    |> put_flash(:info, "Parent deleted successfully.")
    |> redirect(to: parent_path(conn, :index))
  end

  def email_list(conn, _params) do
    parents = Parent |> order_by([:last_name, :first_name]) |> where([p], not is_nil(p.email)) |> Repo.all
    conn
    |> put_resp_content_type("text/csv")
    |> put_resp_header("Content-Disposition", "attachment; filename=\"contact_list.csv\"")
    |> put_status(200)
    |> render("email_list.csv", parents: parents, group: "Parent Emails")
  end
end
