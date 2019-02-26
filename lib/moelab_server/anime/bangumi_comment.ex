defmodule MoelabServer.Anime.BangumiComment do
  use Ecto.Schema
  import Ecto.Changeset
  alias MoelabServer.{Accounts, Anime}

  @required_fields ~w(body author_id bangumi_id)a

  schema "bangumi_comments" do
    field(:body, :string)
    belongs_to(:author, Accounts.User)
    belongs_to(:bangumi, Anime.Bangumi)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(bangumi_comment, attrs) do
    bangumi_comment
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:author_id)
    |> foreign_key_constraint(:bangumi_id)
  end
end
