defmodule MoelabServer.Repo.Migrations.CreateBangumiSubscribers do
  use Ecto.Migration

  def change do
    create table(:bangumi_subscribers) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :bangumi_id, references(:bangumi, on_delete: :delete_all)

      timestamps()
    end

    create index(:bangumi_subscribers, [:user_id])
    create index(:bangumi_subscribers, [:bangumi_id])
    create unique_index(:bangumi_subscribers, [:user_id, :bangumi_id])
  end
end
