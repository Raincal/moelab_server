defmodule MoelabServerWeb.Schema.Utils.Helper do
  alias MoelabServer.Anime

  # see: https://github.com/absinthe-graphql/absinthe/issues/363
  defmacro pagination_args() do
    quote do
      field(:page, :integer, default_value: 1)
      field(:size, :integer, default_value: 10)
    end
  end

  defmacro pagination_fields do
    quote do
      field(:total_count, :integer)
      field(:page_size, :integer)
      field(:total_pages, :integer)
      field(:page_number, :integer)
    end
  end

  defmacro timestamp_fields do
    quote do
      field(:inserted_at, :datetime)
      field(:updated_at, :datetime)
    end
  end

  defmacro bangumi_args() do
    quote do
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
    end
  end

  defmacro comments_fields do
    quote do
      field(:id, :id)
      field(:body, :string)
      field(:author, :user, resolve: dataloader(Anime))

      timestamp_fields()
    end
  end
end
