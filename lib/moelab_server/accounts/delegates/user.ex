defmodule MoelabServer.Accounts.Delegates.User do
  @moduledoc """
  accounts user
  """

  alias Helper.ORM
  alias MoelabServer.Accounts.User

  @doc """
  Returns the list of users.
  """
  def list_users(filter), do: ORM.find_all(User, filter)

  @doc """
  Gets a single user.
  """
  def get_user(id), do: ORM.find(User, id)

  @doc """
  Creates a user.
  """
  def create_user(attrs) do
    input_attrs = Map.merge(attrs, %{avatar: Gravity.image(attrs.email), nickname: attrs.login})
    ORM.create(User, input_attrs)
  end

  @doc """
  Updates a user.
  """
  def update_user(%User{} = user, attrs), do: ORM.update(user, attrs)

  @doc """
  Deletes a User.
  """
  def delete_user(%User{} = user), do: ORM.delete(user)

  @doc """
  User auth
  """
  def authenticate(email, password) do
    with {:ok, user} <- ORM.find_by(User, email: String.downcase(email)) do
      case check_password(user, password) do
        true -> {:ok, user}
        _ -> {:error, "Incorrect login credentials"}
      end
    end
  end

  defp check_password(user, password) do
    case user do
      nil -> Comeonin.Argon2.dummy_checkpw()
      _ -> Comeonin.Argon2.checkpw(password, user.password_hash)
    end
  end
end
