defmodule Codetogether.Repo do
  use Ecto.Repo,
    otp_app: :codetogether,
    adapter: Ecto.Adapters.Postgres
end
