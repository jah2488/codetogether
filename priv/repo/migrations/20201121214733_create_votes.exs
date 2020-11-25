defmodule Codetogether.Repo.Migrations.CreateVotes do
  use Ecto.Migration

  def change do
    create table(:votes) do
      add :nominee_id, references(:nominees, on_delete: :nothing)

      timestamps()
    end

    create index(:votes, [:nominee_id])
  end
end
