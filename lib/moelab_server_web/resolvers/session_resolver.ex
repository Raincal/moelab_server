defmodule MoelabServerWeb.Resolvers.SessionResolver do
  alias MoelabServer.Accounts

  def login(_, %{input: input}, _) do
    with {:ok, user} <- Accounts.Session.authenticate(input),
         {:ok, jwt_token, _} <- Accounts.Guardian.encode_and_sign(user) do
      {:ok, %{token: jwt_token, user: user}}
    end
  end
end
