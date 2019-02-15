defmodule MoelabServerWeb.Resolvers.AnimeResolver do
  import ShortMaps
  alias MoelabServer.Anime

  def all_bangumi(_, args, _) do
    {:ok, Anime.list_bangumi(args)}
  end

  def create_bangumi(_, %{input: input}, %{context: %{current_user: current_user}}) do
    bangumi_input = Map.merge(input, %{creater_id: current_user.id})

    with {:ok, bangumi} <- Anime.create_bangumi(bangumi_input) do
      {:ok, bangumi}
    end
  end

  def subscribe_bangumi(_, ~m(bangumi_id)a, %{context: %{current_user: current_user}}) do
    Anime.subscribe_bangumi(%Anime.Bangumi{id: bangumi_id}, current_user)
  end

  def unsubscribe_bangumi(_, ~m(bangumi_id)a, %{context: %{current_user: current_user}}) do
    Anime.unsubscribe_bangumi(%Anime.Bangumi{id: bangumi_id}, current_user)
  end

  def bangumi_subscribers(_, ~m(bangumi_id filter)a, _) do
    Anime.bangumi_subscribers(%Anime.Bangumi{id: bangumi_id}, filter)
  end

  def bangumi_subscribers(_, _, _), do: {:error, "invalid args"}

  def create_tag(_, %{bangumi_id: bid, name: tag_name}, _) do
    {:ok, Anime.create_tag(bid, tag_name)}
  end

  def create_genre(_, %{bangumi_id: bid, name: genre_name}, _) do
    {:ok, Anime.create_genre(bid, genre_name)}
  end
end
