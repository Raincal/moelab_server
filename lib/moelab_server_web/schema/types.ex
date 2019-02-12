defmodule MoelabServer.Schema.Types do
  use Absinthe.Schema.Notation

  alias MoelabServer.Schema.Types

  import_types(Types.AccountsTypes)
  import_types(Types.SessionTypes)
end
