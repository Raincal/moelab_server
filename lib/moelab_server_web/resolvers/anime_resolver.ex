defmodule MoelabServerWeb.Resolvers.AnimeResolver do
  alias MoelabServer.Anime

  def all_bangumi(_, _, _) do
    {:ok, Anime.list_bangumi()}
  end
end
