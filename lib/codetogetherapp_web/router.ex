defmodule CodetogetherappWeb.Router do
  import Ecto.Query, warn: false
  alias Codetogetherapp.Repo

  use CodetogetherappWeb, :router
  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :auth_user
    plug :put_user_token
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CodetogetherappWeb do
    pipe_through :browser

    get "/", PageController, :index

    get "/games", GameController, :index
    get "/games/:id", GameController, :show
  end

  scope "/admin", CodetogetherappWeb do
    pipe_through :browser
    resources "/games", GameController
  end

  defp auth_user(conn, _) do
    if conn.cookies["user_token"] do
      if user = Repo.get_by(Codetogetherapp.Codetogetherapp.User, token: conn.cookies["user_token"]) do
        assign(conn, :current_user, user)
      else
        token = :crypto.strong_rand_bytes(64) |> Base.url_encode64()
        {:ok, user} = Repo.insert(%Codetogetherapp.Codetogetherapp.User{ token: token, color: token, ip: Enum.join(Tuple.to_list(conn.remote_ip), "") })
        put_resp_cookie(conn, "user_token", token)
        assign(conn, :current_user, user)
      end
    else
      token = :crypto.strong_rand_bytes(64) |> Base.url_encode64()
      {:ok, user} = Repo.insert(%Codetogetherapp.Codetogetherapp.User{ token: token, color: token, ip: Enum.join(Tuple.to_list(conn.remote_ip), "") })
      put_resp_cookie(conn, "user_token", token)
      assign(conn, :current_user, user)
    end
  end

  defp put_user_token(conn, _) do
    if current_user = conn.assigns[:current_user] do
      token = Phoenix.Token.sign(conn, "user socket", current_user.id)
      color = current_user.color
      assign(conn, :user_token, token)
      assign(conn, :user_color, color)
    else
      conn
    end
  end


  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: CodetogetherappWeb.Telemetry, ecto_repos: [Codetogetherapp.Repo]
    end
  end
end
