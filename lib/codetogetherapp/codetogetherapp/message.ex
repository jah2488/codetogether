defmodule Codetogetherapp.Codetogetherapp.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :body, :string
    field :is_code, :boolean, default: false
    field :program, :id
    field :user, :id

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:body, :is_code])
    |> validate_required([:body, :is_code])
  end
end
