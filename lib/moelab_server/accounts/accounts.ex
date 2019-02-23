defmodule MoelabServer.Accounts do
  @moduledoc false

  alias MoelabServer.Accounts.Delegates.{Profile, User}

  defdelegate authenticate(email, password), to: User
  defdelegate list_users(filter), to: User
  defdelegate get_user(id), to: User
  defdelegate create_user(attrs), to: User
  defdelegate update_user(user, attrs), to: User
  defdelegate delete_user(user), to: User

  defdelegate subscribed_bangumi(user, filter), to: Profile
end
