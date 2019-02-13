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
  end

  # subscription do
  # end

  def middleware(middleware, field, object) do
    middleware
    |> apply(:errors, field, object)
  end

  defp apply(middleware, :errors, _field, %{identifier: :mutation}) do
    middleware ++ [Middleware.ChangesetErrors]
  end

  defp apply(middleware, _, _, _) do
    middleware
  end
end
