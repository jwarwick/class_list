defmodule ClassList.DirectoryController do
  use ClassList.Web, :controller
  alias ClassList.Class
  alias ClassList.Student

  def index(conn, _params) do
    classes = Class
              |> Class.sorted
              |> Repo.all
              |> Repo.preload([students: from(Student, order_by: [:last_name])])
              |> Repo.preload([students: [:bus, :class, [parents: :address]]])
    render(conn, "index.html", classes: classes)
  end
end
