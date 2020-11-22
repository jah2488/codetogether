defmodule Codetogetherapp.Repo do
  use Ecto.Repo,
    otp_app: :codetogetherapp,
    adapter: Ecto.Adapters.Postgres
end
