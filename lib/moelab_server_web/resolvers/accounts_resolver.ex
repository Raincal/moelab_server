defmodule MoelabServerWeb.Resolvers.AccountsResolver do
  alias MoelabServer.Accounts

  def users(_, _, _) do
    {:ok, Accounts.list_users()}
  end

  def register(_, %{input: input}, _) do
    input = Map.merge(input, %{avatar: Gravity.image(input.email)})

    with {:ok, user} <- Accounts.create_user(input) do
      {:ok, %{user: user}}
    end
  end

  def login(_, %{email: email, password: password}, _) do
    with {:ok, user} <- Accounts.Session.authenticate(email, password),
         {:ok, jwt_token, _} <- Accounts.Guardian.encode_and_sign(user) do
      {:ok, %{token: jwt_token, user: user}}
    end
  end
end
