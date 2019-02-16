defmodule MoelabServerWeb.Schema.Anime.AnimeMutations do
  use Absinthe.Schema.Notation

  alias MoelabServerWeb.Resolvers
  alias MoelabServerWeb.Schema.Middleware

  object :anime_mutations do
    @desc "Create a new bangumi"
    field :create_bangumi, :bangumi do
      arg(:input, non_null(:bangumi_input))
      middleware(Middleware.Authorize, :any)
      resolve(&Resolvers.AnimeResolver.create_bangumi/3)
    end

    @desc "Update a bangumi"
    field :update_bangumi, :bangumi do
      arg(:bangumi_id, :id)
      arg(:input, non_null(:bangumi_input))
      middleware(Middleware.Authorize, :any)
      resolve(&Resolvers.AnimeResolver.update_bangumi/3)
    end

    @desc "Delete a bangumi"
    field :delete_bangumi, :bangumi do
      arg(:id, non_null(:id))
      middleware(Middleware.Authorize, :any)
      resolve(&Resolvers.AnimeResolver.delete_bangumi/3)
    end

    @desc "Subscribe a bangumi"
    field :subscribe_bangumi, :bangumi do
      arg(:bangumi_id, non_null(:id))
      middleware(Middleware.Authorize, :any)
      resolve(&Resolvers.AnimeResolver.subscribe_bangumi/3)
    end

    @desc "Unsubscribe a bangumi"
    field :unsubscribe_bangumi, :bangumi do
      arg(:bangumi_id, non_null(:id))
      middleware(Middleware.Authorize, :any)
      resolve(&Resolvers.AnimeResolver.unsubscribe_bangumi/3)
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
