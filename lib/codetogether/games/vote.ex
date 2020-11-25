defmodule Codetogether.Games.Vote do
  use Ecto.Schema
  import Ecto.Changeset

  schema "votes" do
    field :nominee, :id

    timestamps()
  end

  @doc false
  def changeset(vote, attrs) do
    vote
    |> cast(attrs, [])
    |> validate_required([])
  end
end
