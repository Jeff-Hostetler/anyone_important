defmodule AnyoneImportant.UserController do
  use AnyoneImportant.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

end