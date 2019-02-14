defmodule MoelabServer.Repo.Migrations.CreateBangumiTags do
  use Ecto.Migration

  def change do
    create table(:bangumi_tags) do
      add(:bangumi_id, references(:bangumi, on_delete: :nothing))
      add(:tag_id, references(:tags, on_delete: :nothing))
    end

    create(index(:bangumi_tags, [:bangumi_id]))
    create(index(:bangumi_tags, [:tag_id]))
    create(unique_index(:bangumi_tags, [:bangumi_id, :tag_id]))
  end
end
