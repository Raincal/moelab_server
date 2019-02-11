# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :moelab_server,
  ecto_repos: [MoelabServer.Repo]

# Configures the endpoint
config :moelab_server, MoelabServerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "oKJ+D1J3HUIR5DTWwWrcpxYyUFRvivxXQVVGM1qy+x5FpppwPoSlHEV8K0QloDYZ",
  render_errors: [view: MoelabServerWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: MoelabServer.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
