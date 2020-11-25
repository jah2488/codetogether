defmodule Codetogether.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string, null: false, default: "guest-user"
      add :token, :string, null: false
      add :color, :string, null: false
      add :account_type, :string, null: false, default: "user"
      add :ip, :string

      timestamps()
    end
  end
end
