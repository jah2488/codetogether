defmodule Codetogether.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Codetogether.Repo,
      # Start the Telemetry supervisor
      CodetogetherWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Codetogether.PubSub},
      # Start the Endpoint (http/https)
      CodetogetherWeb.Endpoint,
      # Start a worker by calling: Codetogether.Worker.start_link(arg)
      # {Codetogether.Worker, arg}
      CodetogetherWeb.Presence
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Codetogether.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    CodetogetherWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
