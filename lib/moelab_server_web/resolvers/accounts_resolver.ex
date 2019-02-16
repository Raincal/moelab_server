defmodule MoelabServerWeb.Resolvers.AccountsResolver do
  import ShortMaps
  alias MoelabServer.Accounts

  def list_users(_, ~m(filter)a, _) do
    Accounts.list_users(filter)
  end

  def list_users(_, _, _) do
    Accounts.list_users(%{page: 1, size: 10})
  end

  def register(_, %{input: input}, _) do
    input = Map.merge(input, %{avatar: Gravity.image(input.email)})

    Accounts.create_user(input)
  end

  def login(_, %{email: email, password: password}, _) do
    with {:ok, user} <- Accounts.authenticate(email, password),
         {:ok, jwt_token, _} <- Accounts.Guardian.encode_and_sign(user) do
      {:ok, %{token: jwt_token, user: user}}
    end
  end

  def subscribed_bangumi(_, ~m(user_id filter)a, _) do
    Accounts.subscribed_bangumi(%Accounts.User{id: user_id}, filter)
  end

  def subscribed_bangumi(_, ~m(filter)a, %{context: %{current_user: current_user}}) do
    Accounts.subscribed_bangumi(%Accounts.User{id: current_user.id}, filter)
  end
end
