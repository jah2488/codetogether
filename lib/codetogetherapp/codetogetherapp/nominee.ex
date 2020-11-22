defmodule Codetogetherapp.Codetogetherapp.Nominee do
  use Ecto.Schema
  import Ecto.Changeset

  schema "nominees" do
    field :body, :string
    field :votes_count, :integer
    field :program, :id

    timestamps()
  end

  @doc false
  def changeset(nominee, attrs) do
    nominee
    |> cast(attrs, [:body, :votes_count])
    |> validate_required([:body, :votes_count])
  end
end
