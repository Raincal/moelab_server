defmodule MoelabServerWeb.Resolvers.AccountsResolver do
  import ShortMaps
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

  def subscribed_bangumi(_, ~m(user_id filter)a, _) do
    Accounts.subscribed_bangumi(%Accounts.User{id: user_id}, filter)
  end

  def subscribed_bangumi(_, ~m(filter)a, %{context: %{current_user: current_user}}) do
    Accounts.subscribed_bangumi(%Accounts.User{id: current_user.id}, filter)
  end
end
