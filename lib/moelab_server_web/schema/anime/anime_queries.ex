defmodule MoelabServerWeb.Schema.Anime.AnimeQueries do
  use Absinthe.Schema.Notation
  alias MoelabServerWeb.Resolvers

  object :anime_queries do
    @desc "Get a bangumi"
    field :bangumi, :bangumi do
      arg(:id, non_null(:id))
      resolve(&Resolvers.AnimeResolver.bangumi/3)
    end

    @desc "Get a list of all bangumi"
    field :all_bangumi, :paged_bangumi do
      arg(:filter, :bangumi_filter)
      resolve(&Resolvers.AnimeResolver.all_bangumi/3)
    end

    @desc "Paged subscribers of a bangumi"
    field :bangumi_subscribers, :paged_users do
      arg(:id, :id)
      arg(:filter, :user_paged_filter)
      resolve(&Resolvers.AnimeResolver.bangumi_subscribers/3)
    end
  end
end
