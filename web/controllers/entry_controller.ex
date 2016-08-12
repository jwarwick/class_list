defmodule ClassList.EntryController do
  use ClassList.Web, :controller

  alias ClassList.Entry

  def index(conn, _params) do
    entries = Entry |> order_by([desc: :inserted_at]) |> Repo.all
    render(conn, "index.html", entries: entries)
  end

  def entry(conn, _params) do
    conn
    |> put_layout({ClassList.EntryView, "script_layout.html"})
    |> render("entry.html", support_email: "bob@gmail.com")
  end

  def create_entry(conn, %{"entry" => entry_params}) do
    IO.inspect entry_params
    changeset = Entry.changeset(%Entry{}, %{data: :erlang.term_to_binary(entry_params)})

    case Repo.insert(changeset) do
      {:ok, _entry} ->
        conn
        |> put_layout({ClassList.EntryView, "layout.html"})
        |> render("thanks.html")
      {:error, _changeset} ->
        conn
        |> put_layout({ClassList.EntryView, "script_layout.html"})
        |> render("entry.html", support_email: "bob@gmail.com")
    end
  end

  def show(conn, %{"id" => id}) do
    entry = Repo.get!(Entry, id)
    entry = %Entry{entry | data: :erlang.binary_to_term(entry.data)}
    render(conn, "show.html", entry: entry)
  end

  def delete(conn, %{"id" => id}) do
    entry = Repo.get!(Entry, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(entry)

    conn
    |> put_flash(:info, "Entry deleted successfully.")
    |> redirect(to: entry_path(conn, :index))
  end
end
