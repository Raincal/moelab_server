defmodule MoelabServer.Anime.BangumiSubscriber do
  use Ecto.Schema
  import Ecto.Changeset
  alias MoelabServer.{Accounts, Anime}

  @required_fields ~w(user_id bangumi_id)a

  schema "bangumi_subscribers" do
    belongs_to(:user, Accounts.User, foreign_key: :user_id)
    belongs_to(:bangumi, Anime.Bangumi, foreign_key: :bangumi_id)

    timestamps()
  end

  @doc false
  def changeset(bangumi_subscriber, attrs) do
    bangumi_subscriber
    |> cast(attrs, [@required_fields])
    |> validate_required([@required_fields])
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:bangumi_id)
    |> unique_constraint(:user_id, name: :bangumi_subscribers_user_id_bangumi_id_index)
  end
end
