defmodule Codetogetherapp.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :body, :string, null: false
      add :is_code, :boolean, default: false, null: false
      add :game, references(:games, on_delete: :nothing)
      add :user, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:messages, [:game])
    create index(:messages, [:user])
  end
end
