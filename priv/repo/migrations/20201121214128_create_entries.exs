defmodule Codetogetherapp.Repo.Migrations.CreateEntries do
  use Ecto.Migration

  def change do
    create table(:entries) do
      add :body, :string, null: false
      add :game, references(:games, on_delete: :nothing)

      timestamps()
    end

    create index(:entries, [:game])
  end
end
