defmodule MoelabServerWeb.Schema.Mutation.AccountsTest do
  use MoelabServerWeb.ConnCase, async: true

  @query """
  mutation ($email: String!) {
    login(email: $email, password: "super-secret") {
      token
      user { name }
    }
  }
  """
  test "creating an user session" do
    user = Factory.create_user("user")

    response =
      post(build_conn(), "/api", %{
        query: @query,
        variables: %{"email" => user.email}
      })

    assert %{
             "data" => %{
               "login" => %{
                 "token" => token,
                 "user" => user_data
               }
             }
           } = json_response(response, 200)

    assert %{"name" => user.name} == user_data
  end
end
