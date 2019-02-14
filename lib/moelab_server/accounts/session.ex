defmodule MoelabServer.Accounts.Session do
  alias MoelabServer.Accounts.User
  alias MoelabServer.Repo

  def authenticate(email, password) do
    user = Repo.get_by(User, email: String.downcase(email))

    case check_password(user, password) do
      true -> {:ok, user}
      _ -> {:error, "Incorrect login credentials"}
    end
  end

  defp check_password(user, password) do
    case user do
      nil -> Comeonin.Argon2.dummy_checkpw()
      _ -> Comeonin.Argon2.checkpw(password, user.password_hash)
    end
  end
end
