defmodule MoelabServerWeb.Router do
  use MoelabServerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MoelabServerWeb do
    pipe_through :api
  end
end
