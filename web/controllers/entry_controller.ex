defmodule ClassList.EntryController do
  use ClassList.Web, :controller

  alias ClassList.Entry

  def index(conn, _params) do
    entries = Repo.all(Entry)
    render(conn, "index.html", entries: entries)
  end

  def entry(conn, _params) do
    conn
    |> put_layout({ClassList.EntryView, "layout.html"})
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
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    entry = Repo.get!(Entry, id)
    entry = %Entry{entry | data: :erlang.binary_to_term(entry.data)}
    render(conn, "show.html", entry: entry)
  end
end
