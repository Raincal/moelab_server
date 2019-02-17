defmodule MoelabServer.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :login, :string
      add :nickname, :string
      add :email, :string
      add :password_hash, :string
      add :avatar, :string
      add :role, :string

      timestamps()
    end

    create(unique_index(:users, [:email]))
    create(unique_index(:users, [:login]))
  end
end
