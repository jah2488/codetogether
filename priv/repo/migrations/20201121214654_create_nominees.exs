defmodule Codetogether.Repo.Migrations.CreateNominees do
  use Ecto.Migration

  def change do
    create table(:nominees) do
      add :body, :string
      add :votes_count, :integer
      add :game_id, references(:games, on_delete: :nothing)

      timestamps()
    end

    create index(:nominees, [:game_id])
  end
end
