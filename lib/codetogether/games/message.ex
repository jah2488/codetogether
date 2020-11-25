defmodule Codetogether.Games.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :body, :string
    field :is_code, :boolean, default: false
    field :game_id, :id
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:body, :is_code, :game_id])
    |> validate_required([:body, :is_code, :game_id])
  end
end
