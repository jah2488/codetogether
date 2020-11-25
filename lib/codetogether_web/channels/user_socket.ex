defmodule CodetogetherWeb.UserSocket do
  use Phoenix.Socket

  channel "game:*", CodetogetherWeb.GameChannel
  channel "admin:*", CodetogetherWeb.AdminChannel

  @impl true
  def connect(%{"token" => token}, socket, _connect_info) do
    {:ok, socket}
    # case Phoenix.Token.verify(socket, "user socket", token, max_age: 1209600) do
    #   {:ok, user_id} ->
    #     {:ok, assign(socket, :current_user, user_id)}
    #   {:error, reason} ->
    #     :error
    # end
  end

  @impl true
  def id(_socket), do: nil
end
