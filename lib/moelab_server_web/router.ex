defmodule MoelabServerWeb.Router do
  use MoelabServerWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
    plug(MoelabServerWeb.Context)
  end

  scope "/" do
    pipe_through(:api)

    forward("/api", Absinthe.Plug, schema: PlateSlateWeb.Schema)

    if Mix.env() == :dev do
      forward("/graphiql", Absinthe.Plug.GraphiQL,
        schema: MoelabServerWeb.Schema,
        interface: :playground
      )
    end
  end
end
