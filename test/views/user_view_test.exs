defmodule AnyoneImportant.UserViewTest do
  use AnyoneImportant.ConnCase, async: true
  alias AnyoneImportant.UserView
  alias AnyoneImportant.User

  test "all_users returns a list of all users" do
  %User{name: "J Hizzo", email: "jhizzo@example.com"}
    |> Repo.insert

  %User{name: "Marcy Madness", email: "omg@example.com"}
    |> Repo.insert

    result = UserView.all_users

    assert Enum.count(result) == 2
  end
end