defmodule Helper.Utils do
  @moduledoc """
  unitil functions
  """
  import Ecto.Query, warn: false
  import Helper.ErrorHandler

  @doc """
  handle General {:ok, ..} or {:error, ..} return
  """
  def done(nil, :boolean), do: {:ok, false}
  def done(_, :boolean), do: {:ok, true}
  def done(nil, err_msg), do: {:error, err_msg}
  def done({:ok, _}, with: result), do: {:ok, result}
  def done({:error, error}, with: _result), do: {:error, error}

  def done({:ok, %{id: id}}, :status), do: {:ok, %{done: true, id: id}}
  def done({:error, _}, :status), do: {:ok, %{done: false}}

  def done(nil, queryable, id), do: {:error, not_found_formater(queryable, id)}
  def done(result, _, _), do: {:ok, result}

  def done(nil), do: {:error, "record not found."}

  # for delete_all, update_all
  # see: https://groups.google.com/forum/#!topic/elixir-ecto/1g5Pp6ceqFE
  def done({n, nil}) when is_integer(n), do: {:ok, %{done: true}}

  # def done({:error, error}), do: {:error, error}
  def done(result), do: {:ok, result}
end
