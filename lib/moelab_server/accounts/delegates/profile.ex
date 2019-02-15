defmodule MoelabServer.Accounts.Delegates.Profile do
  @moduledoc """
  accounts profile
  """
  import Ecto.Query, warn: false
  import Helper.Utils, only: [done: 1]
  import ShortMaps

  alias Helper.{ORM, QueryBuilder}
  alias MoelabServer.Accounts.User
  alias MoelabServer.Anime.BangumiSubscriber

  @doc """
  Get user's subscribed bangumi
  """
  def subscribed_bangumi(%User{id: id}, ~m(page size)a = filter) do
    BangumiSubscriber
    |> where([sb], sb.user_id == ^id)
    |> join(:inner, [sb], b in assoc(sb, :bangumi))
    |> select([sb, b], b)
    |> QueryBuilder.filter_pack(filter)
    |> ORM.paginater(~m(page size)a)
    |> done()
  end
end
