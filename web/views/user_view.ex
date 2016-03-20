defmodule AnyoneImportant.UserView do
  use AnyoneImportant.Web, :view
  alias AnyoneImportant.User
  alias AnyoneImportant.Repo

  def all_users do
    Repo.all(User)
  end
end
