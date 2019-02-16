defmodule MoelabServer.Anime.Delegates.BgmOperation do
  import ShortMaps

  @moduledoc """
  Bangumi operations
  """
  import Ecto.Query, warn: false

  alias Helper.ORM
  alias MoelabServer.Accounts.User
  alias MoelabServer.Anime.{Bangumi, BangumiSubscriber, Tag, BangumiTag, Genre, BangumiGenre}

  @doc """
  Create a tag
  """
  def create_tag(bangumi, tag_name) when is_binary(tag_name) do
    attrs = %{name: tag_name}

    with {:ok, tag} <- ORM.findby_or_insert(Tag, attrs, attrs) do
      create_tag(bangumi, tag.id)
    end
  end

  def create_tag(%{bangumi_id: bid}, tid) do
    create_tag(bid, tid)
  end

  def create_tag(%Bangumi{} = bangumi, tid) do
    create_tag(bangumi.id, tid)
  end

  def create_tag(bid, tid) do
    ORM.create(BangumiTag, %{bangumi_id: bid, tag_id: tid})
  end

  @doc """
  Create a genre
  """
  def create_genre(bangumi, genre_name) when is_binary(genre_name) do
    attrs = %{name: genre_name}

    with {:ok, genre} <- ORM.findby_or_insert(Genre, attrs, attrs) do
      create_genre(bangumi, genre.id)
    end
  end

  def create_genre(%{bangumi_id: bid}, gid) do
    create_genre(bid, gid)
  end

  def create_genre(%Bangumi{} = bangumi, gid) do
    create_genre(bangumi.id, gid)
  end

  def create_genre(bid, gid) do
    ORM.create(BangumiGenre, %{bangumi_id: bid, genre_id: gid})
  end

  @doc """
  Subscribe a bangumi
  """
  def subscribe_bangumi(%Bangumi{id: bangumi_id}, %User{id: user_id}) do
    with {:ok, record} <- BangumiSubscriber |> ORM.create(~m(user_id bangumi_id)a) do
      Bangumi |> ORM.find(record.bangumi_id)
    end
  end

  @doc """
  Unsubscribe a bangumi
  """
  def unsubscribe_bangumi(%Bangumi{id: bangumi_id}, %User{id: user_id}) do
    with {:ok, bangumi} <- ORM.find(Bangumi, bangumi_id),
         {:ok, record} <-
           ORM.findby_delete(BangumiSubscriber, bangumi_id: bangumi.id, user_id: user_id) do
      Bangumi |> ORM.find(record.bangumi_id)
    else
      error ->
        error
    end
  end
end
