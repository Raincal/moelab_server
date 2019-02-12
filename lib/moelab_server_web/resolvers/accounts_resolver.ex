defmodule MoelabServerWeb.Resolvers.AccountsResolver do
  alias MoelabServer.Accounts

  def users(_, _, _) do
    {:ok, Accounts.list_users()}
  end

  def register(_, %{input: input}, _) do
    input = Map.merge(input, %{avatar: Gravity.image(input.email)})
    Accounts.create_user(input)
  end
end
