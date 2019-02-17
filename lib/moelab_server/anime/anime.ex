defmodule MoelabServer.Anime do
  @moduledoc false

  alias Helper.QueryBuilder
  alias MoelabServer.Repo
  alias MoelabServer.Anime.BangumiSubscriber
  alias MoelabServer.Anime.Delegates.{BgmOperation, BgmCURD}

  defdelegate list_bangumi(filter), to: BgmCURD

  defdelegate bangumi_subscribers(bangumi, filters), to: BgmCURD

  defdelegate create_tag(bangumi, tag_name), to: BgmOperation
  defdelegate create_genre(bangumi, genre_name), to: BgmOperation
  defdelegate subscribe_bangumi(bangumi, user), to: BgmOperation
  defdelegate unsubscribe_bangumi(bangumi, user), to: BgmOperation

  def data() do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  def query(BangumiSubscriber, args),
    do:
      BangumiSubscriber
      |> QueryBuilder.members_pack(args)

  def query(queryable, _) do
    queryable
  end
end
