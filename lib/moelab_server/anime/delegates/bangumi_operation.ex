defmodule MoelabServer.Anime.Delegates.BangumiOperation do
  import ShortMaps

  @moduledoc """
  Bangumi operations
  """
  import Ecto.Query, warn: false

  alias Helper.ORM
  alias MoelabServer.Accounts.User
  alias MoelabServer.Anime.{Bangumi, BangumiSubscriber}

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
