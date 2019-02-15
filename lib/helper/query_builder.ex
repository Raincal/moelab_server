defmodule Helper.QueryBuilder do
  import Ecto.Query, warn: false

  def filter_pack(queryable, filter) when is_map(filter) do
    Enum.reduce(filter, queryable, fn
      # Sort
      {:sort, :new}, queryable ->
        queryable |> order_by(desc: :recent_update_time)

      {:sort, :hot}, queryable ->
        queryable |> order_by(desc: :hot)

      # Filter
      {:title, title}, query ->
        from(q in query, where: ilike(q.title, ^"%#{title}%"))

      {:country, country}, query ->
        from(q in query, where: q.countries == ^country)

      {:state, state}, query ->
        from(q in query, where: q.state == ^state)

      {:year, year}, query ->
        from(q in query, where: q.pub_year == ^year)

      {:week, week}, query ->
        from(q in query, where: q.refresh_tag == ^week)

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
