defmodule Factory do
  def create_user(role) do
    int = :erlang.unique_integer([:positive, :monotonic])

    params = %{
      name: "Person #{int}",
      username: "person#{int}",
      avatar: "some avatar",
      email: "fake-#{int}@example.com",
      password: "super-secret",
      password_confirmation: "super-secret",
      role: role
    }

    %MoelabServer.Accounts.User{}
    |> MoelabServer.Accounts.User.changeset(params)
    |> MoelabServer.Repo.insert!()
  end
end
