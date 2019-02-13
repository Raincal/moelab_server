alias MoelabServer.Repo
alias MoelabServer.Anime.Bangumi

url =
  "https://main.neets.cc/items/search?pageNo=1&pageSize=30&country=&tags=&subType=animation&year=&key=&week=&orderBy=1&itemState="

required_fields =
  ~w(aka audit_status bg_photo brief_summary casts countries current_season current_series directors episodes_count languages mainland_pubdate original_title photo pub_year rating refresh_tag rgb seasons_count state subtype summary thumbs title vo_id recent_update_time)a

response = url |> HTTPoison.get!() |> (&Poison.decode!(&1.body)).()

bangumi_list =
  response["list"]
  |> Enum.map(fn map ->
    for {key, val} <- map, into: %{}, do: {key |> Macro.underscore() |> String.to_atom(), val}
  end)
  |> Enum.map(fn map ->
    with {:ok, datetime} <- DateTime.from_unix(map[:recent_update_time], :millisecond) do
      map
      |> Map.take(required_fields)
      |> Map.put(:inserted_at, DateTime.utc_now())
      |> Map.put(:updated_at, DateTime.utc_now())
      |> Map.put(:recent_update_time, datetime |> DateTime.truncate(:second))
    end
  end)

Repo.insert_all(Bangumi, bangumi_list)
