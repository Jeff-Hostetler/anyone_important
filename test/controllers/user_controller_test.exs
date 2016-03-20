defmodule AnyoneImportant.ContactControllerTest do
  use AnyoneImportant.ConnCase
  alias AnyoneImportant.User

  test "/index returns a list of users" do
    %User{name: "J Hizzo", email: "jhizzo@example.com"}
    |> Repo.insert

    conn = get conn, "/users"
    assert html_response(conn, 200) =~ "J Hizzo"
    assert html_response(conn, 200) =~ "jhizzo@example.com"
  end
end