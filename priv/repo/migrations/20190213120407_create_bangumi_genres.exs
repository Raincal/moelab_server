defmodule MoelabServer.Repo.Migrations.CreateBangumiGenres do
  use Ecto.Migration

  def change do
    create table(:bangumi_genres, primary_key: false) do
      add :bangumi_id, references(:bangumi), null: false
      add :genre_id, references(:genres), null: false
    end
  end
end
