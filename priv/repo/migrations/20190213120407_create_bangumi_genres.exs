defmodule MoelabServer.Repo.Migrations.CreateBangumiGenres do
  use Ecto.Migration

  def change do
    create table(:bangumi_genres) do
      add :bangumi_id, references(:bangumi, on_delete: :nothing)
      add :genre_id, references(:genres, on_delete: :nothing)
    end

    create index(:bangumi_genres, [:bangumi_id])
    create index(:bangumi_genres, [:genre_id])
    create(unique_index(:bangumi_genres, [:bangumi_id, :genre_id]))
  end
end
