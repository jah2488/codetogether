defmodule Codetogetherapp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Codetogetherapp.Repo,
      # Start the Telemetry supervisor
      CodetogetherappWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Codetogetherapp.PubSub},
      # Start the Endpoint (http/https)
      CodetogetherappWeb.Endpoint,
      # Start a worker by calling: Codetogetherapp.Worker.start_link(arg)
      # {Codetogetherapp.Worker, arg}
      CodetogetherappWeb.Presence
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Codetogetherapp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    CodetogetherappWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
