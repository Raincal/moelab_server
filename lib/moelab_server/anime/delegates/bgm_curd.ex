defmodule MoelabServer.Anime.Delegates.BgmCURD do
  import ShortMaps

  @moduledoc """
  Bangumi CURD
  """
  import Ecto.Query, warn: false
  import Helper.Utils, only: [done: 1]
  import ShortMaps

  alias Helper.{ORM, QueryBuilder}
  alias MoelabServer.Anime.{Bangumi, BangumiSubscriber}

  @doc """
  Returns the list of bangumi.
  """
  def list_bangumi(filter), do: ORM.find_all(Bangumi, filter)

  @doc """
  Gets a single bangumi.
  """
  def get_bangumi(id), do: ORM.find(Bangumi, id)

  @doc """
  Creates a bangumi.
  """
  def create_bangumi(attrs \\ %{}), do: ORM.create(Bangumi, attrs)

  @doc """
  Updates a bangumi.
  """
  def update_bangumi(%Bangumi{} = bangumi, attrs), do: ORM.update(bangumi, attrs)

  @doc """
  Deletes a Bangumi.
  """
  def delete_bangumi(%Bangumi{} = bangumi), do: ORM.delete(bangumi)

  @doc """
  Get a list of bangumi subscribers
  """
  def bangumi_subscribers(%Bangumi{id: id}, ~m(page size)a = filter)
      when not is_nil(id) do
    BangumiSubscriber
    |> where([c], c.bangumi_id == ^id)
    |> QueryBuilder.load_inner_users(filter)
    |> ORM.paginater(~m(page size)a)
    |> done()
  end
end
