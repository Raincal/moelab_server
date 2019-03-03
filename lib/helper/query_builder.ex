defmodule Helper.QueryBuilder do
  import Ecto.Query, warn: false

  def members_pack(queryable, %{filter: filter}) do
    queryable |> load_inner_users(filter)
  end

  def members_pack(queryable, %{viewer_did: _, current_user: current_user}) do
    queryable |> where([f], f.user_id == ^current_user.id)
  end

  def members_pack(queryable, %{viewer_did: _}) do
    queryable |> where([f], f.user_id == 0)
  end

  def members_pack(queryable, %{count: _, type: :bangumi}) do
    queryable
    |> group_by([f], f.bangumi_id)
    |> select([f], count(f.id))
  end

  def load_inner_users(queryable, filter) do
    queryable
    |> join(:inner, [f], u in assoc(f, :user))
    |> select([f, u], u)
    |> filter_pack(filter)
  end

  def filter_pack(queryable, filter) when is_map(filter) do
    Enum.reduce(filter, queryable, fn
      # Sort
      {:sort, :new}, queryable ->
        queryable |> order_by(desc: :recent_update_time)

      {:sort, :hot}, queryable ->
        queryable |> order_by(desc: :hot)

      {:sort, :recent}, queryable ->
        queryable |> order_by([sb, b], desc: b.recent_update_time)

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

      {:first, first}, queryable ->
        queryable |> limit(^first)

      {_, _}, queryable ->
        queryable
    end)
  end
end
