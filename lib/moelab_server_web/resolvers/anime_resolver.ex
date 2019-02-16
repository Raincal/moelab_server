defmodule MoelabServerWeb.Resolvers.AnimeResolver do
  import ShortMaps
  alias MoelabServer.Anime

  def all_bangumi(_, ~m(filter)a, _) do
    Anime.list_bangumi(filter)
  end

  def all_bangumi(_, _, _) do
    Anime.list_bangumi(%{page: 1, size: 10})
  end

  def create_bangumi(_, %{input: input}, %{context: %{current_user: current_user}}) do
    bangumi_input = Map.merge(input, %{creater_id: current_user.id})

    Anime.create_bangumi(bangumi_input)
  end

  def update_bangumi(_, ~m(bangumi_id input)a, %{context: %{current_user: current_user}}) do
    bangumi_input = Map.merge(input, %{creater_id: current_user.id})
    Anime.update_bangumi(bangumi_id, bangumi_input)
  end

  def update_bangumi(_, %{input: input}, %{context: %{current_user: current_user}}) do
    bangumi_input = Map.merge(input, %{creater_id: current_user.id})
    Anime.update_bangumi(bangumi_input)
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
    Anime.create_tag(bid, tag_name)
  end

  def create_genre(_, %{bangumi_id: bid, name: genre_name}, _) do
    Anime.create_genre(bid, genre_name)
  end
end
