defmodule MoelabServerWeb.Schema.Account.AccountQueries do
  use Absinthe.Schema.Notation

  alias MoelabServerWeb.Resolvers
  alias MoelabServerWeb.Schema.Middleware

  object :account_queries do
    @desc "Get a list of all users"
    field :users, list_of(:user) do
      middleware(Middleware.Authorize, :any)
      resolve(&Resolvers.AccountsResolver.users/3)
    end
  end
end
