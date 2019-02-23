defmodule MoelabServer.Seeds do
  alias MoelabServer.{Repo, Anime, Accounts}

  @required_fields ~w(aka audit_status bg_photo brief_summary casts countries current_season current_series directors episodes_count languages mainland_pubdate original_title photo pub_year rating refresh_tag rgb seasons_count state subtype summary thumbs title vo_id recent_update_time)a

  def run() do
    url =
      "https://main.neets.cc/items/search?pageNo=1&pageSize=30&country=&tags=&subType=animation&year=&key=&week=&orderBy=1&itemState="

    response = url |> HTTPoison.get!() |> (&Poison.decode!(&1.body)).()

    insert_user()
    response["list"] |> transform_list() |> insert_bangumi()
    response["list"] |> insert_genres_and_tags()
  end

  defp insert_user do
    Accounts.create_user(%{
      email: "foo@example.com",
      login: "foo",
      password: "foo123",
      password_confirmation: "foo123",
      avatar: "abc"
    })
  end

  defp transform_list(list) do
    list
    |> Enum.map(fn map ->
      for {key, val} <- map, into: %{}, do: {key |> Macro.underscore() |> String.to_atom(), val}
    end)
    |> Enum.map(fn map ->
      with {:ok, datetime} <- DateTime.from_unix(map[:recent_update_time], :millisecond) do
        map
        |> Map.take(@required_fields)
        |> Map.put(:creater_id, 1)
        |> Map.put(:inserted_at, DateTime.utc_now())
        |> Map.put(:updated_at, DateTime.utc_now())
        |> Map.put(:recent_update_time, datetime |> DateTime.truncate(:second))
      end
    end)
  end

  defp insert_bangumi(list) do
    Repo.insert_all(Anime.Bangumi, list)
  end

  defp insert_genres_and_tags(list) do
    Enum.each(list, fn bangumi ->
      if bangumi["genres"] != "" do
        genres = String.split(bangumi["genres"], ",")

        bangumi = Anime.Bangumi |> Repo.get_by!(vo_id: bangumi["voId"])

        for genre <- genres do
          MoelabServer.Anime.create_genre(bangumi.id, genre)
        end
      end

      if bangumi["tags"] != "" do
        tags = String.split(bangumi["tags"], ",")

        bangumi = Anime.Bangumi |> Repo.get_by!(vo_id: bangumi["voId"])

        for tag <- tags do
          MoelabServer.Anime.create_tag(bangumi.id, tag)
        end
      end
    end)
  end
end
