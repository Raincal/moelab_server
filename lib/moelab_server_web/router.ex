defmodule MoelabServerWeb.Router do
  use MoelabServerWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
    plug(MoelabServerWeb.Context)
  end

  scope "/" do
    pipe_through(:api)

    forward("/api", Absinthe.Plug, schema: MoelabServerWeb.Schema)

    forward("/graphiql", Absinthe.Plug.GraphiQL,
      schema: MoelabServerWeb.Schema,
      pipeline: {ApolloTracing.Pipeline, :plug},
      interface: :playground
    )
  end
end
