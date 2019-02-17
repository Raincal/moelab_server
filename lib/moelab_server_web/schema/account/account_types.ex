defmodule MoelabServerWeb.Schema.Account.AccountTypes do
  use Absinthe.Schema.Notation
  import MoelabServerWeb.Schema.Utils.Helper

  object :user do
    field(:id, :id)
    field(:login, :string)
    field(:nickname, :string)
    field(:email, :string)
    field(:avatar, :string)
    field(:role, :string)
  end

  object :paged_users do
    field(:entries, list_of(:user))
    pagination_fields()
  end

  input_object :user_paged_filter do
    field(:sort, :user_sort_enum)
    pagination_args()
  end

  input_object :sub_bangumi_filter do
    field(:sort, :sub_bangumi_sort_enum)
    pagination_args()
  end

  input_object :user_input do
    field(:login, non_null(:string))
    field(:email, non_null(:string))
    field(:role, :string)
    field(:password, non_null(:string))
    field(:password_confirmation, non_null(:string))
  end

  object :session do
    field(:token, :string)
    field(:user, :user)
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
