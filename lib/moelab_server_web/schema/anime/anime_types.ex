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
    field(:id, :id)
    field(:countries, :string)
    field(:rating, :float)
    field(:rgb, :string)
    field(:episodes_count, :integer)
    field(:bg_photo, :string)
    field(:refresh_tag, :string)
    field(:summary, :string)
    field(:subtype, :string)
    field(:recent_update_time, :datetime)
    field(:original_title, :string)
    field(:directors, :string)
    field(:audit_status, :integer)
    field(:current_series, :float)
    field(:current_season, :integer)
    field(:title, :string)
    field(:aka, :string)
    field(:languages, :string)
    field(:pub_year, :string)
    field(:mainland_pubdate, :string)
    field(:state, :integer)
    field(:brief_summary, :string)
    field(:photo, :string)
    field(:seasons_count, :integer)
    field(:casts, :string)
    field(:vo_id, :string)
    field(:genres, list_of(:genre), resolve: dataloader(Anime))
    field(:tags, list_of(:tag), resolve: dataloader(Anime))
  end

  object :genre do
    field(:name, :string)
  end

  object :tag do
    field(:name, :string)
  end
end
