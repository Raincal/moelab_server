defmodule MoelabServerWeb.Resolvers.AnimeResolver do
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
end
