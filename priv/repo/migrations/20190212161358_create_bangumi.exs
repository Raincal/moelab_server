defmodule MoelabServer.Repo.Migrations.CreateBangumi do
  use Ecto.Migration

  def change do
    create table(:bangumi) do
      add :aka, :string
      add :audit_status, :integer
      add :bg_photo, :string
      add :brief_summary, :text
      add :casts, :string
      add :countries, :string
      add :current_season, :integer
      add :current_series, :float
      add :directors, :string
      add :episodes_count, :integer
      add :languages, :string
      add :mainland_pubdate, :string
      add :original_title, :string
      add :photo, :string
      add :pub_year, :string
      add :rating, :float
      add :recent_update_time, :utc_datetime
      add :refresh_tag, :string
      add :rgb, :string
      add :seasons_count, :integer
      add :state, :integer
      add :subtype, :string
      add :summary, :text
      add :thumbs, {:map, :string}
      add :title, :string
      add :vo_id, :string

      timestamps()
    end

    create(unique_index(:bangumi, [:vo_id]))
  end
end
