defmodule MoelabServerWeb.Schema.Anime.AnimeMutations do
  use Absinthe.Schema.Notation

  alias MoelabServerWeb.Resolvers

  object :anime_mutations do
    @desc "Create a new bangumi"
    field :create_bangumi, :bangumi do
      arg(:input, non_null(:bangumi_input))
      resolve(&Resolvers.AnimeResolver.create_bangumi/3)
    end

    @desc "Create a new tag"
    field :create_tag, :bangumi_tag do
      arg(:bangumi_id, :id)
      arg(:name, :string)
      resolve(&Resolvers.AnimeResolver.create_tag/3)
    end

    @desc "Create a new genre"
    field :create_genre, :bangumi_genre do
      arg(:bangumi_id, :id)
      arg(:name, :string)
      resolve(&Resolvers.AnimeResolver.create_genre/3)
    end
  end
end
