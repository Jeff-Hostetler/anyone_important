defmodule AnyoneImportant.UserController do
  use AnyoneImportant.Web, :controller
  alias AnyoneImportant.User
  alias AnyoneImportant.Repo

  plug :scrub_params, "user" when action in [:create, :update]

  def index(conn, _params) do
    conn
    |> put_flash(:info, "You are now on the list.")
    |> assign(:all_users, Repo.all(User))
    |> assign(:new_user, User.changeset(%User{}))
    |> render("index.html")
  end

  def create(conn, %{"user" => user_params}) do
    %User{name: user_params["name"], email: user_params["email"]}
    |>Repo.insert!

    conn
    |> put_flash(:info, "You are now on the list.")
    |> redirect(to: user_path(conn, :index))
  end

end