defmodule MoelabServerWeb.Schema.Anime.AnimeTypes do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers
  alias MoelabServer.Anime

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
  end

  object :genre do
    field(:name, :string)
  end
end
