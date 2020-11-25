defmodule Codetogether.Admin.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field :can_vote, :boolean, default: false
    field :complete, :boolean, default: false
    field :confetti, :boolean, default: false
    field :description, :string
    field :max_input, :integer
    field :mode, :string
    field :name, :string
    field :play_state, :string
    field :vote_interval, :integer
    field :vote_threshold, :integer

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [
      :name,
      :description,
      :mode,
      :complete,
      :max_input,
      :vote_interval,
      :vote_threshold,
      :can_vote,
      :confetti,
      :play_state
    ])
    |> validate_required([
      :name,
      :mode
    ])
  end
end
