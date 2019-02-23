defmodule MoelabServerWeb.Schema do
  use Absinthe.Schema
  alias MoelabServerWeb.Schema.Middleware

  import_types(MoelabServerWeb.Schema.Types)

  query do
    import_fields(:account_queries)
    import_fields(:anime_queries)
  end

  mutation do
    import_fields(:account_mutations)
    import_fields(:anime_mutations)
  end

  # subscription do
  # end

  def middleware(middleware, field, object) do
    middleware
    |> apply(:apollo_cache, field, object)
    |> apply(:apollo_trace, field, object)
    |> apply(:errors, field, object)
  end

  defp apply(middleware, :apollo_cache, _field, %{identifier: :query}) do
    [ApolloTracing.Middleware.Caching] ++ middleware
  end

  defp apply(middleware, :apollo_trace, _field, _object) do
    [ApolloTracing.Middleware.Tracing] ++ middleware
  end

  defp apply(middleware, :errors, _field, %{identifier: :mutation}) do
    middleware ++ [Middleware.ChangesetErrors]
  end

  defp apply(middleware, _, _, _) do
    middleware
  end

  def plugins do
    [Absinthe.Middleware.Dataloader | Absinthe.Plugin.defaults()]
  end

  def dataloader() do
    alias MoelabServer.Anime

    Dataloader.new()
    |> Dataloader.add_source(Anime, Anime.data())
  end

  def context(ctx) do
    Map.put(ctx, :loader, dataloader())
  end
end
