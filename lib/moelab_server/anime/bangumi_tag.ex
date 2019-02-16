defmodule MoelabServer.Anime.BangumiTag do
  use Ecto.Schema
  import Ecto.Changeset
  alias MoelabServer.Anime.{Bangumi, Tag}

  schema "bangumi_tags" do
    belongs_to(:bangumi, Bangumi)
    belongs_to(:tag, Tag)
  end

  @doc false
  def changeset(bangumi_tag, attrs) do
    bangumi_tag
    |> cast(attrs, [:bangumi_id, :tag_id])
    |> validate_required([:bangumi_id, :tag_id])
    |> unique_constraint(:bangumi_id, name: :bangumi_tags_bangumi_id_tag_id_index)
  end
end
