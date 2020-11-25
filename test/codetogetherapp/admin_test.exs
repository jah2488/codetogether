defmodule Codetogether.AdminTest do
  use Codetogether.DataCase

  alias Codetogether.Admin

  describe "games" do
    alias Codetogether.Admin.Game

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def game_fixture(attrs \\ %{}) do
      {:ok, game} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Admin.create_game()

      game
    end

    test "list_games/0 returns all games" do
      game = game_fixture()
      assert Admin.list_games() == [game]
    end

    test "get_game!/1 returns the game with given id" do
      game = game_fixture()
      assert Admin.get_game!(game.id) == game
    end

    test "create_game/1 with valid data creates a game" do
      assert {:ok, %Game{} = game} = Admin.create_game(@valid_attrs)
    end

    test "create_game/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Admin.create_game(@invalid_attrs)
    end

    test "update_game/2 with valid data updates the game" do
      game = game_fixture()
      assert {:ok, %Game{} = game} = Admin.update_game(game, @update_attrs)
    end

    test "update_game/2 with invalid data returns error changeset" do
      game = game_fixture()
      assert {:error, %Ecto.Changeset{}} = Admin.update_game(game, @invalid_attrs)
      assert game == Admin.get_game!(game.id)
    end

    test "delete_game/1 deletes the game" do
      game = game_fixture()
      assert {:ok, %Game{}} = Admin.delete_game(game)
      assert_raise Ecto.NoResultsError, fn -> Admin.get_game!(game.id) end
    end

    test "change_game/1 returns a game changeset" do
      game = game_fixture()
      assert %Ecto.Changeset{} = Admin.change_game(game)
    end
  end

  describe "games" do
    alias Codetogether.Admin.Game

    @valid_attrs %{mode: "some mode", name: "some name"}
    @update_attrs %{mode: "some updated mode", name: "some updated name"}
    @invalid_attrs %{mode: nil, name: nil}

    def game_fixture(attrs \\ %{}) do
      {:ok, game} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Admin.create_game()

      game
    end

    test "list_games/0 returns all games" do
      game = game_fixture()
      assert Admin.list_games() == [game]
    end

    test "get_game!/1 returns the game with given id" do
      game = game_fixture()
      assert Admin.get_game!(game.id) == game
    end

    test "create_game/1 with valid data creates a game" do
      assert {:ok, %Game{} = game} = Admin.create_game(@valid_attrs)
      assert game.mode == "some mode"
      assert game.name == "some name"
    end

    test "create_game/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Admin.create_game(@invalid_attrs)
    end

    test "update_game/2 with valid data updates the game" do
      game = game_fixture()
      assert {:ok, %Game{} = game} = Admin.update_game(game, @update_attrs)
      assert game.mode == "some updated mode"
      assert game.name == "some updated name"
    end

    test "update_game/2 with invalid data returns error changeset" do
      game = game_fixture()
      assert {:error, %Ecto.Changeset{}} = Admin.update_game(game, @invalid_attrs)
      assert game == Admin.get_game!(game.id)
    end

    test "delete_game/1 deletes the game" do
      game = game_fixture()
      assert {:ok, %Game{}} = Admin.delete_game(game)
      assert_raise Ecto.NoResultsError, fn -> Admin.get_game!(game.id) end
    end

    test "change_game/1 returns a game changeset" do
      game = game_fixture()
      assert %Ecto.Changeset{} = Admin.change_game(game)
    end
  end
end
