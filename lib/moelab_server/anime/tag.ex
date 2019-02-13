defmodule MoelabServer.Anime.Tag do
  use Ecto.Schema
  import Ecto.Changeset
  alias MoelabServer.Anime.Bangumi

  schema "tags" do
    field(:name, :string)

    many_to_many(:bangumi, Bangumi, join_through: "bangumi_tags")

    timestamps()
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
