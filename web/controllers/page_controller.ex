defmodule ClassList.PageController do
  use ClassList.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
