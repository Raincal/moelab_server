defmodule MoelabServerWeb.Schema.Account.AccountMutations do
  use Absinthe.Schema.Notation

  alias MoelabServerWeb.Resolvers

  object :account_mutations do
    @desc "Register a new user"
    field :register, :register_result do
      arg(:input, non_null(:user_input))
      resolve(&Resolvers.AccountsResolver.register/3)
    end

    @desc "Login a user and return a JWT token"
    field :login, :session do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))
      resolve(&Resolvers.AccountsResolver.login/3)
    end
  end
end
