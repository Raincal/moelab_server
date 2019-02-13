defmodule MoelabServer.Repo.Migrations.CreateBangumiTags do
  use Ecto.Migration

  def change do
    create table(:bangumi_tags, primary_key: false) do
      add :bangumi_id, references(:bangumi), null: false
      add :tag_id, references(:tags), null: false
    end
  end
end
