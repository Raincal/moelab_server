defmodule MoelabServer.Schema.Types.SessionTypes do
  use Absinthe.Schema.Notation

  object :session do
    field(:token, :string)
    field(:user, :user)
  end

  input_object :session_input do
    field(:email, non_null(:string))
    field(:password, non_null(:string))
  end
end
