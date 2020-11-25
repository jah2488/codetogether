# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :codetogether,
  ecto_repos: [Codetogether.Repo]

# Configures the endpoint
config :codetogether, CodetogetherWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "mx5RGkeTpyb4vFrQca0d8EqRuSHxwLJf8Xrhj7Bqn1yuOY4r2HkZGKDlBJCrs9C0",
  render_errors: [view: CodetogetherWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Codetogether.PubSub,
  live_view: [signing_salt: "xE1f4B6J6f37D9ar2XvLkpHv7lA+c/7/4D4ANDoi"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
