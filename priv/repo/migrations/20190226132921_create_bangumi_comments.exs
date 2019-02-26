defmodule MoelabServer.Repo.Migrations.CreateBangumiComments do
  use Ecto.Migration

  def change do
    create table(:bangumi_comments) do
      add :body, :string
      add :author_id, references(:users, on_delete: :delete_all)
      add :bangumi_id, references(:bangumi, on_delete: :delete_all)

      timestamps()
    end

    create index(:bangumi_comments, [:author_id])
    create index(:bangumi_comments, [:bangumi_id])
  end
end
