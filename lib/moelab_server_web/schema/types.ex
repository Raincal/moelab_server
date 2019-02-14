defmodule MoelabServerWeb.Schema.Types do
  use Absinthe.Schema.Notation

  alias MoelabServerWeb.Schema.{Account, Anime, Util}

  import_types(Util.CommonTypes)

  import_types(Account.AccountTypes)
  import_types(Account.AccountQueries)
  import_types(Account.AccountMutations)

  import_types(Anime.AnimeTypes)
  import_types(Anime.AnimeQueries)
  import_types(Anime.AnimeMutations)
end
