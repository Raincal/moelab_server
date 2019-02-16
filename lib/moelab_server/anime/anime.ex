defmodule MoelabServer.Anime do
  @moduledoc false

  alias MoelabServer.Repo
  alias MoelabServer.Anime.Delegates.{BgmOperation, BgmCURD}

  defdelegate list_bangumi(filter), to: BgmCURD
  defdelegate get_bangumi(id), to: BgmCURD
  defdelegate create_bangumi(attrs), to: BgmCURD
  defdelegate update_bangumi(bangumi, attrs), to: BgmCURD
  defdelegate delete_bangumi(bangumi), to: BgmCURD

  defdelegate bangumi_subscribers(bangumi, filters), to: BgmCURD

  defdelegate create_tag(bangumi, tag_name), to: BgmOperation
  defdelegate create_genre(bangumi, genre_name), to: BgmOperation
  defdelegate subscribe_bangumi(bangumi, user), to: BgmOperation
  defdelegate unsubscribe_bangumi(bangumi, user), to: BgmOperation

  def data() do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  def query(queryable, _) do
    queryable
  end
end
