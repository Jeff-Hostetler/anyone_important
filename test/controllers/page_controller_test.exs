defmodule AnyoneImportant.PageControllerTest do
  use AnyoneImportant.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Does anyone important follow you?"
  end

  test "GET /help", %{conn: conn} do
    conn = get conn, "/help"
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end
end
