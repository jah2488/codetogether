defmodule Codetogetherapp.Codetogetherapp.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :account_type, :string
    field :color, :string
    field :ip, :string
    field :name, :string
    field :token, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :token, :color, :ip, :account_type])
    |> validate_required([:name, :token, :color, :ip, :account_type])
  end
end
