defmodule MoelabServerWeb.Schema do
  use Absinthe.Schema

  alias MoelabServerWeb.Resolvers
  alias MoelabServerWeb.Schema.Middleware

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

  # import Types
  import_types(MoelabServer.Schema.Types)

  query do
    @desc "Get a list of all users"
    field :users, list_of(:user) do
      middleware(Middleware.Authorize, :any)
      resolve(&Resolvers.AccountsResolver.users/3)
    end
  end

  mutation do
    @desc "Register a new user"
    field :register, :register_result do
      arg(:input, non_null(:user_input))
      resolve(&Resolvers.AccountsResolver.register/3)
    end

    @desc "Login a user and return a JWT token"
    field :login, :session do
      arg(:input, non_null(:session_input))
      resolve(&Resolvers.SessionResolver.login/3)
    end
  end

  # subscription do
  # end
end
