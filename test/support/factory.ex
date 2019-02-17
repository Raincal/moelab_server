defmodule Factory do
  alias MoelabServer.{Repo, Accounts, Anime}

  def create_user(role) do
    int = :erlang.unique_integer([:positive, :monotonic])

    params = %{
      login: "person#{int}",
      nickname: "person#{int}",
      avatar: "some avatar",
      email: "fake-#{int}@example.com",
      password: "super-secret",
      password_confirmation: "super-secret",
      role: role
    }

    %Accounts.User{}
    |> Accounts.User.changeset(params)
    |> Repo.insert!()
  end

  def create_bangumi() do
    user = create_user("user")

    params = %{
      audit_status: 3,
      directors: "Some Directors",
      vo_id: "Some VoId",
      current_season: 0,
      bg_photo: "Some Photo",
      inserted_at: DateTime.utc_now(),
      subtype: "animation",
      state: 0,
      aka: "Some aka",
      refresh_tag: "7",
      current_series: 872.0,
      mainland_pubdate: "2019",
      episodes_count: 999,
      summary: "Some Summary",
      brief_summary: "Some Summary",
      rgb: "b9b974",
      creater_id: user.id,
      photo: "Some Photo",
      title: "Some title",
      languages: "English",
      updated_at: DateTime.utc_now(),
      rating: 9.5,
      seasons_count: 0,
      casts: "Some Casts",
      countries: "USA",
      original_title: "Some Title",
      pub_year: "2019",
      recent_update_time: DateTime.utc_now()
    }

    %Anime.Bangumi{}
    |> Anime.Bangumi.changeset(params)
    |> Repo.insert!()
  end
end
