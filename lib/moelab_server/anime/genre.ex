defmodule MoelabServer.Anime.Genre do
  use Ecto.Schema
  import Ecto.Changeset
  alias MoelabServer.Anime.Bangumi

  schema "genres" do
    field(:name, :string)

    many_to_many(:bangumi, Bangumi, join_through: "bangumi_genres")

    timestamps()
  end

  @doc false
  def changeset(genre, attrs) do
    genre
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
