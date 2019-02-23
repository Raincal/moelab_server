defmodule MoelabServerWeb.Schema.Middleware.ChangesetErrors do
  @behaviour Absinthe.Middleware

  alias MoelabServerWeb.Gettext, as: Translator

  def call(%{errors: [%Ecto.Changeset{} = changeset]} = resolution, _) do
    resolution
    |> Absinthe.Resolution.put_result({:error, message: transform_errors(changeset)})
  end

  def call(resolution, _), do: resolution

  defp transform_errors(changeset) do
    changeset
    |> Ecto.Changeset.traverse_errors(&format_error/1)
    |> Enum.map(fn {key, err_msg_list} ->
      err_msg = err_msg_list |> List.first()

      cond do
        Map.has_key?(err_msg, :count) ->
          %{
            key: Translator |> Gettext.dgettext("fields", "#{key}"),
            message: Translator |> Gettext.dgettext("errors", err_msg.raw, count: err_msg.count)
          }

        true ->
          %{
            key: Translator |> Gettext.dgettext("fields", "#{key}"),
            message: Translator |> Gettext.dgettext("errors", err_msg.msg)
          }
      end
    end)
  end

  defp format_error({msg, opts}) do
    err_string =
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)

    cond do
      String.contains?(msg, "%{count}") ->
        %{
          msg: err_string,
          count: Keyword.get(opts, :count),
          raw: msg
        }

      true ->
        %{
          msg: err_string
        }
    end
  end
end
