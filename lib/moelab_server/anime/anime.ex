defmodule MoelabServer.Anime do
  @moduledoc """
  The Anime context.
  """

  import Ecto.Query, warn: false
  alias MoelabServer.Repo

  alias MoelabServer.Anime.Bangumi
  alias MoelabServer.Anime.Genre

  @doc """
  Returns the list of genres.
  """
  def list_genres do
    Repo.all(Genre)
  end

  @doc """
  Gets a single genre.

  Raises `Ecto.NoResultsError` if the Genre does not exist.
  """
  def get_genre!(id), do: Repo.get!(Genre, id)

  @doc """
  Creates a genre.
  """
  def create_genre(attrs \\ %{}) do
    %Genre{}
    |> Genre.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a genre.
  """
  def update_genre(%Genre{} = genre, attrs) do
    genre
    |> Genre.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Genre.
  """
  def delete_genre(%Genre{} = genre) do
    Repo.delete(genre)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking genre changes.
  """
  def change_genre(%Genre{} = genre) do
    Genre.changeset(genre, %{})
  end

  @doc """
  Returns the list of bangumi.

  ## Examples

      iex> list_bangumi()
      [%Bangumi{}, ...]

  """
  def list_bangumi do
    Repo.all(Bangumi)
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
end
