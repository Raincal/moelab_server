defmodule MoelabServerWeb.Schema.Anime.AnimeTypes do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers
  import MoelabServerWeb.Schema.Utils.Helper
  alias MoelabServer.Anime

  @desc "Filtering options for the bangumi list"
  input_object :bangumi_filter do
    pagination_args()

    @desc "Matching a title"
    field(:title, :string)

    @desc "Matching a country"
    field(:country, :string)

    @desc "Matching a state"
    field(:state, :integer)

    @desc "Matching a year"
    field(:year, :string)

    @desc "Matching a week"
    field(:week, :string)

    @desc "Matching a genre name"
    field(:genre, :string)

    @desc "Matching a tag"
    field(:tag, :string)
  end

  object :paged_bangumi do
    field(:entries, list_of(:bangumi))
    pagination_fields()
  end

  object :bangumi do
    bangumi_args()
    field(:creater, :user, resolve: dataloader(Anime))
    field(:genres, list_of(:genre), resolve: dataloader(Anime))
    field(:tags, list_of(:tag), resolve: dataloader(Anime))
  end

  input_object :bangumi_input do
    bangumi_args()
  end

  object :genre do
    field(:name, :string)
  end

  object :tag do
    field(:name, :string)
  end

  object :bangumi_tag do
    field(:bangumi, :bangumi, resolve: dataloader(Anime))
    field(:tag, :tag, resolve: dataloader(Anime))
  end

  object :bangumi_genre do
    field(:bangumi, :bangumi, resolve: dataloader(Anime))
    field(:genre, :genre, resolve: dataloader(Anime))
  end
end
