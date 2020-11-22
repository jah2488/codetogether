defmodule Codetogetherapp.Repo.Migrations.CreateVotes do
  use Ecto.Migration

  def change do
    create table(:votes) do
      add :nominee, references(:nominees, on_delete: :nothing)

      timestamps()
    end

    create index(:votes, [:nominee])
  end
end
