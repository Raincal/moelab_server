defmodule MoelabServer.Accounts.Guardian do
  use Guardian, otp_app: :moelab_server

  alias MoelabServer.Accounts

  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end

  def resource_from_claims(%{"sub" => id}) do
    Accounts.get_user(id)
  end
end
