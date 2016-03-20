defmodule AnyoneImportant.UserController do
  use AnyoneImportant.Web, :controller

  def index(conn, _params) do
    render conn, "user/index.html"
  end

end