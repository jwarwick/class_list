defmodule ClassList.EntryController do
  use ClassList.Web, :controller
  require Logger

  alias ClassList.Entry
  alias ClassList.Mailer

  def index(conn, _params) do
    entries = Entry |> order_by([desc: :inserted_at]) |> Repo.all
    render(conn, "index.html", entries: entries)
  end

  def entry(conn, _params) do
    conn
    |> put_layout({ClassList.EntryView, "script_layout.html"})
    |> render("entry.html", support_email: System.get_env("SUPPORT_EMAIL"))
  end

  def create_entry(conn, %{"entry" => entry_params}) do
    Logger.info "Creating entry: #{inspect entry_params}"
    changeset = Entry.changeset(%Entry{}, %{data: :erlang.term_to_binary(entry_params)})

    case Repo.insert(changeset) do
      {:error, _changeset} ->
        Logger.error "Failed to save entry: #{inspect entry_params}"
      _ ->
        :ok
    end

    ClassList.EntryConverter.convert(entry_params)
    |> check_conversion

    Task.start(fn -> Mailer.send_notification_email(entry_params) end)

    conn
    |> put_layout({ClassList.EntryView, "layout.html"})
    |> render("thanks.html")
  end

  defp check_conversion(params = {students, addresses, parents}) do
    result = 
      [students, addresses, parents]
      |> List.flatten
      |> Enum.all?(&check_ok/1)

    unless result do
      Logger.error "Failed to convert entry: #{inspect params}"
    end
  end

  defp check_ok({:ok, _}), do: true
  defp check_ok(_), do: false

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
