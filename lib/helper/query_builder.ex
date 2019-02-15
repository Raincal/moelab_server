defmodule Helper.QueryBuilder do
  import Ecto.Query, warn: false

  def filter_pack(queryable, filter) when is_map(filter) do
    Enum.reduce(filter, queryable, fn
      # Sort
      {:sort, :new}, queryable ->
        queryable |> order_by([sb, b], desc: b.recent_update_time)

      {:sort, :hot}, queryable ->
        queryable |> order_by([sb, b], desc: b.hot)

      # Filter
      {:title, title}, queryable ->
        from(q in queryable, where: ilike(q.title, ^"%#{title}%"))

      {:country, country}, queryable ->
        from(q in queryable, where: q.countries == ^country)

      {:state, state}, queryable ->
        from(q in queryable, where: q.state == ^state)

      {:year, year}, queryable ->
        from(q in queryable, where: q.pub_year == ^year)

      {:week, week}, queryable ->
        from(q in queryable, where: q.refresh_tag == ^week)

      {:tag, tag_name}, queryable ->
        from(
          q in queryable,
          join: t in assoc(q, :tags),
          where: t.name == ^tag_name
        )

      {:genre, genre}, queryable ->
        from(
          q in queryable,
          join: t in assoc(q, :genres),
          where: t.name == ^genre
        )

      {_, _}, queryable ->
        queryable
    end)
  end
end
