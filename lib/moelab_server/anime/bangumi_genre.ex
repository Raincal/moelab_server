defmodule MoelabServer.Anime.BangumiGenre do
  use Ecto.Schema
  import Ecto.Changeset
  alias MoelabServer.Anime.{Bangumi, Genre}

  schema "bangumi_genres" do
    belongs_to(:bangumi, Bangumi)
    belongs_to(:genre, Genre)
  end

  @doc false
  def changeset(bangumi_genre, attrs) do
    bangumi_genre
    |> cast(attrs, [:bangumi_id, :genre_id])
    |> validate_required([:bangumi_id, :genre_id])
  end
end
