defmodule MoelabServerWeb.Schema.Account.AccountTypes do
  use Absinthe.Schema.Notation

  object :user do
    field(:id, :id)
    field(:name, :string)
    field(:username, :string)
    field(:email, :string)
    field(:avatar, :string)
    field(:role, :string)
  end

  input_object :user_input do
    field(:name, non_null(:string))
    field(:username, non_null(:string))
    field(:email, non_null(:string))
    field(:password, non_null(:string))
    field(:password_confirmation, non_null(:string))
  end

  object :session do
    field(:token, :string)
    field(:user, :user)
  end

  input_object :session_input do
    field(:email, non_null(:string))
    field(:password, non_null(:string))
  end

  object :register_result do
    field(:user, :user)
    field(:errors, list_of(:validation_error))
  end

  @desc "An error encountered trying to persist input"
  object :validation_error do
    field(:key, non_null(:string))
    field(:message, non_null(:string))
  end
end
