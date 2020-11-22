defmodule Codetogetherapp.Repo.Migrations.CreateNominees do
  use Ecto.Migration

  def change do
    create table(:nominees) do
      add :body, :string
      add :votes_count, :integer
      add :game, references(:games, on_delete: :nothing)

      timestamps()
    end

    create index(:nominees, [:game])
  end
end
