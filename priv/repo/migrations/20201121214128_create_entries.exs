defmodule Codetogether.Repo.Migrations.CreateEntries do
  use Ecto.Migration

  def change do
    create table(:entries) do
      add :body, :string, null: false
      add :game_id, references(:games, on_delete: :nothing)

      timestamps()
    end

    create index(:entries, [:game_id])
  end
end
