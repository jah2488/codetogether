defmodule Codetogether.Games do
  import Ecto.Query, warn: false
  alias Codetogether.Repo

  alias Codetogether.Games.Entry
  alias Codetogether.Games.Game
  alias Codetogether.Games.Message
  alias Codetogether.Games.Nominee
  alias Codetogether.Games.Vote

  def get_game(id) do
    from(g in Game,
      # join: m in assoc(g, :messages),
      # join: e in assoc(g, :entries),
      where: g.id == ^id,
      # preload: [messages: m, entries: e]
      preload: [:messages, :entries]
    )
    |> IO.inspect()
    |> Repo.one()
  end

  def create_message(%Game{} = game, body \\ "", is_code \\ false) do
    %Message{}
    |> Message.changeset(%{body: body, is_code: is_code, game_id: game.id})
    |> Repo.insert()
  end

  def find_or_create_nominee(game, name) do
    get_nominee_by_name(game, name) ||
      %Nominee{}
      |> Nominee.changeset(%{body: name, game_id: game.id})
      |> Repo.insert()
  end

  def get_nominee_by_name(game, name) do
    Repo.get_by(Nominee, %{body: name, game_id: game.id})
  end

  def create_entry(%Game{} = game, addition) do
    %Entry{}
    |> Entry.changeset(%{game_id: game.id, body: addition})
    |> Repo.insert()
  end

  def create_vote(%Nominee{} = nominee) do
    %Vote{}
    |> Vote.changeset(%{nominee: nominee.id})
    |> Repo.insert()
  end

  def destroy_nominees(%Game{} = game) do
    from(n in %Nominee{}, where: n.game == ^game.id)
    |> Repo.delete_all()
  end
end
