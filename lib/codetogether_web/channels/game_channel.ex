defmodule CodetogetherWeb.GameChannel do
  use CodetogetherWeb, :channel

  alias Codetogether.Games

  @impl true
  def join("game:lobby", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  @impl true
  def join("game:" <> id, payload, socket) do
    if authorized?(payload) do
      send(self, :after_join)
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_info(:after_join, socket) do
    game =
      socket.topic
      |> String.split(":")
      |> Enum.at(1)
      |> Codetogether.Games.get_game()
      |> game_payload()

    push(socket, "game:loaded", game)
    {:noreply, socket}
  end

  @impl true
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  @impl true
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

  @impl true
  def handle_in("message:new", payload, socket) do
    #
    # This code is still vulnerable to being overloaded by
    # messages and either dropping messages, suffering from
    # race conditions, or deadlocking the database.
    # TODO: Implement: https://hexdocs.pm/ecto/Ecto.Multi.html
    #
    game =
      socket.topic
      |> String.split(":")
      |> Enum.at(1)
      |> Codetogether.Games.get_game()

    addition = payload["addition"]
    is_code = payload["isCode"]
    Games.create_message(game, addition, is_code)

    if is_code do
      nominee = Games.find_or_create_nominee(game, addition)

      if game.mode == "anarchy" do
        Games.create_entry(game, addition)
      else
        Games.create_vote(nominee)

        if nominee.votes_count >= game.vote_threshold do
          Games.create_entry(game, addition)
          Games.destroy_nominees(game)
        end
      end
    else
    end

    {:noreply, socket}
  end

  defp authorized?(_payload) do
    # TODO: add authorization logic here
    true
  end

  defp game_payload(game) do
    messages =
      game.messages
      |> Enum.map(&message_payload/1)

    entries =
      game.entries
      |> Enum.map(fn (e) -> e.body end)
      |> Enum.join("")

    # game.nominees,
    # game.ouput,
    %{
      "can_vote" => game.can_vote,
      "code" => entries,
      "complete" => game.complete,
      "confetti" => game.confetti,
      "description" => game.description,
      "id" => game.id,
      "inserted_at" => game.inserted_at,
      "max_input" => game.max_input,
      "messages" => messages,
      "mode" => game.mode,
      "name" => game.name,
      "nominees" => [],
      "output" => "",
      "play_state" => game.play_state,
      "updated_at" => game.updated_at,
      "vote_interval" => game.vote_interval,
      "vote_threshold" => game.vote_threshold
    }
  end

  def message_payload(message) do
    %{
      "id" => message.id,
      "body" => message.body,
      "is_code" => message.is_code,
      "user_id" => message.user_id
    }
  end
end
