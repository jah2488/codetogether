defmodule CodetogetherappWeb.GameControllerTest do
  use CodetogetherappWeb.ConnCase

  test "GET /games", %{conn: conn} do
    render(conn, "index.html")
  end

  test "GET /games/:id", %{conn: conn} do
    render(conn, "show.html")
  end
end
