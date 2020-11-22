defmodule CodetogetherappWeb.PageController do
  use CodetogetherappWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
