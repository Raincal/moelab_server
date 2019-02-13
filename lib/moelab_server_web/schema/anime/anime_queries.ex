defmodule MoelabServerWeb.Schema.Anime.AnimeQueries do
  use Absinthe.Schema.Notation

  alias MoelabServerWeb.Resolvers

  object :anime_queries do
    @desc "Get a list of all bangumi"
    field :all_bangumi, list_of(:bangumi) do
      resolve(&Resolvers.AnimeResolver.all_bangumi/3)
    end
  end
end
