defmodule CodetogetherappWeb.GameController do
  use CodetogetherappWeb, :controller
  import Ecto.Query, warn: false

  alias Codetogetherapp.Repo
  alias Codetogetherapp.Codetogetherapp.Game

  def index(conn, _params) do
    games = Repo.all(Game)
    render(conn, "index.html", games: games)
  end

  @spec show(Plug.Conn.t(), map) :: Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    game = Repo.get(Game, id)
    render(conn, "show.html", %{game: game})
  end
end
