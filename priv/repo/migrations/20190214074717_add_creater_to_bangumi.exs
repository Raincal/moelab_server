defmodule MoelabServer.Repo.Migrations.AddCreaterToBangumi do
  use Ecto.Migration

  def change do
    alter table(:bangumi) do
      add(:creater_id, references(:users))
    end
  end
end
