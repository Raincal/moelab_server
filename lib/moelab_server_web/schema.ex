defmodule MoelabServerWeb.Schema do
  use Absinthe.Schema

  alias(MoelabServerWeb.Resolvers)

  # import Types
  import_types(MoelabServer.Schema.Types)

  query do
    @desc "Get a list of all users"
    field :users, list_of(:user_type) do
      resolve(&Resolvers.AccountsResolver.users/3)
    end
  end

  mutation do
    @desc "Register a new user"
    field :register_user, type: :user_type do
      arg(:input, non_null(:user_input_type))
      resolve(&Resolvers.AccountsResolver.register_user/3)
    end
  end

  # subscription do
  # end
end
