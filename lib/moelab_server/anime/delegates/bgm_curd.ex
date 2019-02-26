defmodule MoelabServer.Anime.Delegates.BgmCURD do
  import ShortMaps

  @moduledoc """
  Bangumi CURD
  """
  import Ecto.Query, warn: false
  import Helper.Utils, only: [done: 1]
  import ShortMaps

  alias Helper.{ORM, QueryBuilder}
  alias MoelabServer.Anime.{Bangumi, BangumiSubscriber, BangumiComment}

  @doc """
  Returns the list of bangumi.
  """
  def list_bangumi(filter), do: Bangumi |> ORM.find_all(filter)

  @doc """
  Returns the list of bangumi subscribers
  """
  def bangumi_subscribers(%Bangumi{id: id}, ~m(page size)a = filter)
      when not is_nil(id) do
    BangumiSubscriber
    |> where([c], c.bangumi_id == ^id)
    |> QueryBuilder.load_inner_users(filter)
    |> ORM.paginater(~m(page size)a)
    |> done()
  end

  @doc """
  Returns the list of bangumi comments
  """
  def list_comments(id, %{page: page, size: size} = filters) do
    BangumiComment
    |> where([c], c.bangumi_id == ^id)
    |> QueryBuilder.filter_pack(filters)
    |> ORM.paginater(~m(page size)a)
    |> done()
  end
end
