defmodule Codetogether.Repo.Migrations.CreateGame do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :name, :string, null: false
      add :description, :text
      add :play_state, :string, default: "created", null: false
      add :mode, :string, default: "anarchy", null: false
      add :max_input, :integer, default: 1, null: false
      add :vote_threshold, :integer, default: 5, null: false
      add :vote_interval, :integer, default: 10, null: false
      add :can_vote, :boolean, default: false, null: false
      add :confetti, :boolean, default: false, null: false
      add :complete, :boolean, default: false, null: false

      timestamps()
    end
  end
end
