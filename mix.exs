defmodule MoelabServer.MixProject do
  use Mix.Project

  def project do
    [
      app: :moelab_server,
      version: "0.1.0",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {MoelabServer.Application, []},
      extra_applications: [:logger, :runtime_tools, :scrivener_ecto]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "dev/support", "test/support"]
  defp elixirc_paths(_), do: ["lib", "dev/support"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.4.0"},
      {:phoenix_pubsub, "~> 1.1"},
      {:phoenix_ecto, "~> 4.0"},
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:plug_cowboy, "~> 2.0"},
      {:comeonin, "~> 4.0"},
      {:argon2_elixir, "~> 1.2"},
      {:absinthe, "~> 1.4.13"},
      {:absinthe_phoenix, "~> 1.4.3"},
      {:absinthe_plug, "~> 1.4.5"},
      {:absinthe_ecto, "~> 0.1.3"},
      {:gravity, "~> 1.0.1"},
      {:guardian, "~> 1.2.1"},
      {:httpoison, "~> 1.5"},
      {:dataloader, "~> 1.0.0"},
      {:apollo_tracing, "~> 0.4.0"},
      {:short_maps, "~> 0.1.1"},
      {:cors_plug, "~> 2.0"},
      {:scrivener_ecto,
       git: "https://github.com/mastani-stack/scrivener_ecto", branch: "dev", override: true}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
