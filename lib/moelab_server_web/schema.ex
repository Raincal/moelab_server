defmodule MoelabServerWeb.Schema do
  use Absinthe.Schema

  alias MoelabServerWeb.Resolvers
  alias MoelabServerWeb.Schema.Middleware

  # import Types
  import_types(MoelabServer.Schema.Types)

  query do
    @desc "Get a list of all users"
    field :users, list_of(:user_type) do
      middleware(Middleware.Authorize, :any)
      resolve(&Resolvers.AccountsResolver.users/3)
    end
  end

  mutation do
    @desc "Register a new user"
    field :register, :user_type do
      arg(:input, non_null(:user_input_type))
      resolve(&Resolvers.AccountsResolver.register/3)
    end

    @desc "Login a user and return a JWT token"
    field :login, :session_type do
      arg(:input, non_null(:session_input_type))
      resolve(&Resolvers.SessionResolver.login/3)
    end
  end

  # subscription do
  # end
end
