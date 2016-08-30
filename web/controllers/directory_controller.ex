defmodule ClassList.DirectoryController do
  use ClassList.Web, :controller
  alias ClassList.Class
  alias ClassList.Student
  alias ClassList.Formatter

  def index(conn, _params) do
    classes = Class
              |> Class.sorted
              |> Repo.all
              |> Repo.preload([students: from(Student, order_by: [:last_name])])
              |> Repo.preload([students: [:bus, :class, [parents: :address]]])
    render(conn, "index.html", classes: classes)
  end

  def download(conn, _params) do
    tmp_file = "directory.rtf"
    tmp_dir = System.tmp_dir!
    tmp_path = Path.join(tmp_dir, tmp_file)
    :ok = Formatter.write(tmp_path)

    conn
    |> put_resp_content_type("application/rtf")
    |> put_resp_header("content-disposition",
                       "attachment; filename=\"#{tmp_file}\"")
    |> send_file(200, tmp_path)
  end
end
