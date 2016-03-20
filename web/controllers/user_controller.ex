defmodule AnyoneImportant.UserController do
  use AnyoneImportant.Web, :controller
  alias AnyoneImportant.User
  alias AnyoneImportant.Repo

  def index(conn, _params) do
    render conn, "index.html", all_users: Repo.all(User)
  end

end