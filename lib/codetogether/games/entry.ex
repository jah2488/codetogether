defmodule Codetogether.Games.Entry do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.Queryable

  schema "entries" do
    field :body, :string
    field :game_id, :id

    timestamps()
  end

  @spec format_name(String.t()) :: String.t()
  def format_name(addition) do
    case addition do
      ":t" -> " \t"
      ":nl" -> " \n"
      ":sp" -> " "
      _ -> addition
    end
  end

  @doc false
  def changeset(entry, attrs) do
    entry
    |> cast(attrs, [:body, :game_id])
    |> validate_required([:game_id])
  end
end
