defmodule MoelabServer.Anime do
  @moduledoc """
  The Anime context.
  """

  import Ecto.Query, warn: false
  alias MoelabServer.Repo

  alias MoelabServer.Anime.{Bangumi, BangumiTag, BangumiGenre, Genre, Tag}

  @doc """
  Returns the list of bangumi.
  """
  def list_bangumi(%{filter: %{page: page, size: size}} = args) do
    args
    |> Enum.reduce(Bangumi, fn
      {:order, order}, query ->
        query |> order_by({^order, :recent_update_time})

      {:filter, filter}, query ->
        query |> filter_with(filter)
    end)
    |> Repo.paginate(page: page, page_size: size)
  end

  def list_bangumi(args) do
    args
    |> Enum.reduce(Bangumi, fn
      {:order, order}, query ->
        query |> order_by({^order, :recent_update_time})

      {:filter, filter}, query ->
        query |> filter_with(filter)
    end)
    |> Repo.paginate()
  end

  defp filter_with(query, filter) do
    Enum.reduce(filter, query, fn
      {:page, _page}, query ->
        query

      {:size, _size}, query ->
        query

      {:title, title}, query ->
        from(q in query, where: ilike(q.title, ^"%#{title}%"))

      {:country, country}, query ->
        from(q in query, where: ilike(q.countries, ^"%#{country}%"))

      {:state, state}, query ->
        from(q in query, where: ilike(q.state, ^"%#{state}%"))

      {:year, year}, query ->
        from(q in query, where: ilike(q.pub_year, ^"%#{year}%"))

      {:week, week}, query ->
        from(q in query, where: ilike(q.refresh_tag, ^"%#{week}%"))

      {:genre, genre_name}, query ->
        from(
          q in query,
          join: g in assoc(q, :genres),
          where: ilike(g.name, ^"%#{genre_name}%")
        )

      {:tag, tag_name}, query ->
        from(
          q in query,
          join: t in assoc(q, :tags),
          where: ilike(t.name, ^"%#{tag_name}%")
        )
    end)
  end

  @doc """
  Gets a single bangumi.

  Raises `Ecto.NoResultsError` if the Bangumi does not exist.

  ## Examples

      iex> get_bangumi!(123)
      %Bangumi{}

      iex> get_bangumi!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bangumi!(id), do: Repo.get!(Bangumi, id)

  @doc """
  Creates a bangumi.

  ## Examples

      iex> create_bangumi(%{field: value})
      {:ok, %Bangumi{}}

      iex> create_bangumi(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bangumi(attrs \\ %{}) do
    %Bangumi{}
    |> Bangumi.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a bangumi.

  ## Examples

      iex> update_bangumi(bangumi, %{field: new_value})
      {:ok, %Bangumi{}}

      iex> update_bangumi(bangumi, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bangumi(%Bangumi{} = bangumi, attrs) do
    bangumi
    |> Bangumi.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Bangumi.

  ## Examples

      iex> delete_bangumi(bangumi)
      {:ok, %Bangumi{}}

      iex> delete_bangumi(bangumi)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bangumi(%Bangumi{} = bangumi) do
    Repo.delete(bangumi)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bangumi changes.

  ## Examples

      iex> change_bangumi(bangumi)
      %Ecto.Changeset{source: %Bangumi{}}

  """
  def change_bangumi(%Bangumi{} = bangumi) do
    Bangumi.changeset(bangumi, %{})
  end

  def create_tag(bangumi, tag_name) when is_binary(tag_name) do
    tag =
      case Repo.get_by(Tag, %{name: tag_name}) do
        nil ->
          %Tag{} |> Tag.changeset(%{name: tag_name}) |> Repo.insert!()

        tag ->
          tag
      end

    create_tag(bangumi, tag.id)
  end

  def create_tag(%{bangumi_id: bid}, tid) do
    create_tag(bid, tid)
  end

  def create_tag(%Bangumi{} = bangumi, tid) do
    create_tag(bangumi.id, tid)
  end

  def create_tag(bid, tid) do
    %BangumiTag{}
    |> BangumiTag.changeset(%{bangumi_id: bid, tag_id: tid})
    |> Repo.insert!()
  end

  def create_genre(bangumi, genre_name) when is_binary(genre_name) do
    genre =
      case Repo.get_by(Genre, %{name: genre_name}) do
        nil ->
          %Genre{} |> Genre.changeset(%{name: genre_name}) |> Repo.insert!()

        genre ->
          genre
      end

    create_genre(bangumi, genre.id)
  end

  def create_genre(%{bangumi_id: bid}, tid) do
    create_genre(bid, tid)
  end

  def create_genre(%Bangumi{} = bangumi, tid) do
    create_genre(bangumi.id, tid)
  end

  def create_genre(bid, tid) do
    %BangumiGenre{}
    |> BangumiGenre.changeset(%{bangumi_id: bid, genre_id: tid})
    |> Repo.insert!()
  end

  def data() do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  def query(queryable, _) do
    queryable
  end
end
