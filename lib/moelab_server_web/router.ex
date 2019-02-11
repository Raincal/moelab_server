defmodule MoelabServerWeb.Router do
  use MoelabServerWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/" do
    pipe_through(:api)

    forward("/api", Absinthe.Plug, schema: PlateSlateWeb.Schema)

    if Mix.env() == :dev do
      forward("/graphiql", Absinthe.Plug.GraphiQL, schema: MoelabServerWeb.Schema)
    end
  end
end
