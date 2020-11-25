defmodule Codetogether.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :body, :string, null: false
      add :is_code, :boolean, default: false, null: false
      add :game_id, references(:games, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:messages, [:game_id])
    create index(:messages, [:user_id])
  end
end
