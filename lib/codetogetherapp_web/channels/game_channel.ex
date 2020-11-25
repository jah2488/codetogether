defmodule CodetogetherappWeb.GameChannel do
  use CodetogetherappWeb, :channel

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
      |> Codetogetherapp.Games.get_game()
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
    {:noreply, socket}
  end

  defp authorized?(_payload) do
    # TODO: add authorization logic here
    true
  end

  defp game_payload(%Codetogetherapp.Codetogetherapp.Game{} = game) do
    game
    |> Map.from_struct()
    |> Map.drop([:__meta__])
  end
end
