defmodule MoelabServer.Repo do
  use Ecto.Repo,
    otp_app: :moelab_server,
    adapter: Ecto.Adapters.Postgres
end
