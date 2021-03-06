defmodule Helper.ORM do
  @moduledoc """
  General CORD functions
  """
  import Ecto.Query, warn: false
  import Helper.Utils, only: [done: 1, done: 3]
  import Helper.ErrorHandler
  import ShortMaps

  alias Helper.{QueryBuilder, SpecType}
  alias MoelabServer.Repo

  @doc """
  a wrap for paginate request
  """
  def paginater(queryable, page: page, size: size) do
    queryable |> Repo.paginate(page: page, page_size: size)
  end

  def paginater(queryable, ~m(page size)a) do
    queryable |> Repo.paginate(page: page, page_size: size)
  end

  @doc """
  wrap Repo.get with preload and result/errer format handle
  """
  def find(queryable, id, preload: preload) do
    queryable
    |> preload(^preload)
    |> Repo.get(id)
    |> done(queryable, id)
  end

  @doc """
  simular to Repo.get/3, with standard result/error handle
  """
  @spec find(Ecto.Queryable.t(), SpecType.id()) :: {:ok, any()} | {:error, String.t()}
  def find(queryable, id) do
    queryable
    |> Repo.get(id)
    |> done(queryable, id)
  end

  @doc """
  simular to Repo.get_by/3, with standard result/error handle
  """
  def find_by(queryable, clauses) do
    queryable
    |> Repo.get_by(clauses)
    |> case do
      nil ->
        {:error, not_found_formater(queryable, clauses)}

      result ->
        {:ok, result}
    end
  end

  @doc """
  return pageinated Data required by filter
  """
  # TODO: find content not in trash by default
  def find_all(queryable, %{page: page, size: size} = filter) do
    queryable
    |> QueryBuilder.filter_pack(filter)
    |> paginater(page: page, size: size)
    |> done()
  end

  @doc """
  return Data required by filter
  """
  # TODO: find content not in trash by default
  def find_all(queryable, filter) do
    queryable |> QueryBuilder.filter_pack(filter) |> Repo.all() |> done()
  end

  @doc """
  NOTICE: this should be use together with Authorize/OwnerCheck etc Middleware
  DO NOT use it directly
  """
  def delete(content), do: Repo.delete(content)

  def find_delete(queryable, id) do
    with {:ok, content} <- find(queryable, id) do
      delete(content)
    end
  end

  def findby_delete(queryable, clauses) do
    with {:ok, content} <- find_by(queryable, clauses) do
      delete(content)
    end
  end

  def findby_or_insert(queryable, clauses, attrs) do
    case queryable |> find_by(clauses) do
      {:ok, content} ->
        {:ok, content}

      {:error, _} ->
        queryable |> create(attrs)
    end
  end

  @doc """
  NOTE: this should be use together with passport_loader etc Middleware
  DO NOT use it directly
  """
  def update(content, attrs) do
    content
    |> content.__struct__.update_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  find and update sourc
  """
  def find_update(queryable, id, attrs), do: do_find_update(queryable, id, attrs)
  def find_update(queryable, %{id: id} = attrs), do: do_find_update(queryable, id, attrs)

  defp do_find_update(queryable, id, attrs) do
    with {:ok, content} <- find(queryable, id) do
      content
      |> content.__struct__.changeset(attrs)
      |> Repo.update()
    end
  end

  @doc """
  find then update
  """
  def update_by(source, clauses, attrs) do
    with {:ok, content} <- find_by(source, clauses) do
      content
      |> Ecto.Changeset.change(attrs)
      |> Repo.update()
    end
  end

  def upsert_by(queryable, clauses, attrs) do
    case queryable |> find_by(clauses) do
      {:ok, content} ->
        content
        |> content.__struct__.changeset(attrs)
        |> Repo.update()

      {:error, _} ->
        queryable |> create(attrs)
    end
  end

  def create(modal, attrs) do
    modal
    |> struct
    |> modal.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  return the total count of a Modal based on id column
  also support filters
  """
  def count(queryable, filter \\ %{}) do
    queryable
    |> QueryBuilder.filter_pack(filter)
    |> select([f], count(f.id))
    |> Repo.one()
  end
end
