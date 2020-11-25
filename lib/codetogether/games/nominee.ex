defmodule Codetogether.Games.Nominee do
  use Ecto.Schema
  import Ecto.Changeset

  schema "nominees" do
    field :body, :string
    field :votes_count, :integer
    field :game_id, :id

    timestamps()
  end

  @doc false
  def changeset(nominee, attrs) do
    nominee
    |> cast(attrs, [:body, :game_id])
    |> validate_required([:body, :game_id])
  end
end
