defmodule AnyoneImportant.PageController do
  use AnyoneImportant.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def help(conn, _params) do
    render conn, "help.html"
  end

end
