defmodule Codetogetherapp.Codetogetherapp.Entry do
  use Ecto.Schema
  import Ecto.Changeset

  schema "entries" do
    field :body, :string
    field :program, :id

    timestamps()
  end

  @doc false
  def changeset(entry, attrs) do
    entry
    |> cast(attrs, [:body])
    |> validate_required([:body])
  end
end
