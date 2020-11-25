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
    game
    |> Map.from_struct()
    |> Enum.map(&convert_to_map/1)
    |> Enum.into(%{})
    |> Map.drop([:__meta__])
  end

  # defp convert_to_map({key, value}), do: {key, value}
  defp convert_to_map({key, value}) when is_map(value) do
    IO.inspect("HIITTTTTTTTTTTTT")
    {key, Map.from_struct(value) |> Map.drop([:__meta__])}
  end
end
