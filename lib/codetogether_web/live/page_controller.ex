defmodule CodetogetherWeb.PageController do
  use CodetogetherWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
