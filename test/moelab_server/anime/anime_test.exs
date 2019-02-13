defmodule MoelabServer.AnimeTest do
  use MoelabServer.DataCase

  alias MoelabServer.Anime

  describe "bangumi" do
    alias MoelabServer.Anime.Bangumi

    @valid_attrs %{voId: "some voId", casts: "some casts", thumbs: "some thumbs", seasonsCount: 42, photo: "some photo", refreshTagTxt: "some refreshTagTxt", briefSummary: "some briefSummary", state: 42, mainlandPubdate: "some mainlandPubdate", pubYear: "some pubYear", languages: "some languages", tags: "some tags", aka: "some aka", title: "some title", currentSeason: 42, currentSeries: 42, auditStatus: 42, subtypeTxt: "some subtypeTxt", auditStatusTxt: "some auditStatusTxt", directors: "some directors", originalTitle: "some originalTitle", recentUpdateTime: "2010-04-17T14:00:00.000000Z", genres: "some genres", subtype: "some subtype", summary: "some summary", refreshTag: "some refreshTag", bgPhoto: "some bgPhoto", episodesCount: 42, tagsTxt: "some tagsTxt", rgb: "some rgb", rating: 120.5, countries: "some countries", stateTxt: "some stateTxt"}
    @update_attrs %{voId: "some updated voId", casts: "some updated casts", thumbs: "some updated thumbs", seasonsCount: 43, photo: "some updated photo", refreshTagTxt: "some updated refreshTagTxt", briefSummary: "some updated briefSummary", state: 43, mainlandPubdate: "some updated mainlandPubdate", pubYear: "some updated pubYear", languages: "some updated languages", tags: "some updated tags", aka: "some updated aka", title: "some updated title", currentSeason: 43, currentSeries: 43, auditStatus: 43, subtypeTxt: "some updated subtypeTxt", auditStatusTxt: "some updated auditStatusTxt", directors: "some updated directors", originalTitle: "some updated originalTitle", recentUpdateTime: "2011-05-18T15:01:01.000000Z", genres: "some updated genres", subtype: "some updated subtype", summary: "some updated summary", refreshTag: "some updated refreshTag", bgPhoto: "some updated bgPhoto", episodesCount: 43, tagsTxt: "some updated tagsTxt", rgb: "some updated rgb", rating: 456.7, countries: "some updated countries", stateTxt: "some updated stateTxt"}
    @invalid_attrs %{voId: nil, casts: nil, thumbs: nil, seasonsCount: nil, photo: nil, refreshTagTxt: nil, briefSummary: nil, state: nil, mainlandPubdate: nil, pubYear: nil, languages: nil, tags: nil, aka: nil, title: nil, currentSeason: nil, currentSeries: nil, auditStatus: nil, subtypeTxt: nil, auditStatusTxt: nil, directors: nil, originalTitle: nil, recentUpdateTime: nil, genres: nil, subtype: nil, summary: nil, refreshTag: nil, bgPhoto: nil, episodesCount: nil, tagsTxt: nil, rgb: nil, rating: nil, countries: nil, stateTxt: nil}

    def bangumi_fixture(attrs \\ %{}) do
      {:ok, bangumi} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Anime.create_bangumi()

      bangumi
    end

    test "list_bangumi/0 returns all bangumi" do
      bangumi = bangumi_fixture()
      assert Anime.list_bangumi() == [bangumi]
    end

    test "get_bangumi!/1 returns the bangumi with given id" do
      bangumi = bangumi_fixture()
      assert Anime.get_bangumi!(bangumi.id) == bangumi
    end

    test "create_bangumi/1 with valid data creates a bangumi" do
      assert {:ok, %Bangumi{} = bangumi} = Anime.create_bangumi(@valid_attrs)
      assert bangumi.stateTxt == "some stateTxt"
      assert bangumi.countries == "some countries"
      assert bangumi.rating == 120.5
      assert bangumi.rgb == "some rgb"
      assert bangumi.tagsTxt == "some tagsTxt"
      assert bangumi.episodesCount == 42
      assert bangumi.bgPhoto == "some bgPhoto"
      assert bangumi.refreshTag == "some refreshTag"
      assert bangumi.summary == "some summary"
      assert bangumi.subtype == "some subtype"
      assert bangumi.genres == "some genres"
      assert bangumi.recentUpdateTime == DateTime.from_naive!(~N[2010-04-17T14:00:00.000000Z], "Etc/UTC")
      assert bangumi.originalTitle == "some originalTitle"
      assert bangumi.directors == "some directors"
      assert bangumi.auditStatusTxt == "some auditStatusTxt"
      assert bangumi.subtypeTxt == "some subtypeTxt"
      assert bangumi.auditStatus == 42
      assert bangumi.currentSeries == 42
      assert bangumi.currentSeason == 42
      assert bangumi.title == "some title"
      assert bangumi.aka == "some aka"
      assert bangumi.tags == "some tags"
      assert bangumi.languages == "some languages"
      assert bangumi.pubYear == "some pubYear"
      assert bangumi.mainlandPubdate == "some mainlandPubdate"
      assert bangumi.state == 42
      assert bangumi.briefSummary == "some briefSummary"
      assert bangumi.refreshTagTxt == "some refreshTagTxt"
      assert bangumi.photo == "some photo"
      assert bangumi.seasonsCount == 42
      assert bangumi.thumbs == "some thumbs"
      assert bangumi.casts == "some casts"
      assert bangumi.voId == "some voId"
    end

    test "create_bangumi/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Anime.create_bangumi(@invalid_attrs)
    end

    test "update_bangumi/2 with valid data updates the bangumi" do
      bangumi = bangumi_fixture()
      assert {:ok, %Bangumi{} = bangumi} = Anime.update_bangumi(bangumi, @update_attrs)
      assert bangumi.stateTxt == "some updated stateTxt"
      assert bangumi.countries == "some updated countries"
      assert bangumi.rating == 456.7
      assert bangumi.rgb == "some updated rgb"
      assert bangumi.tagsTxt == "some updated tagsTxt"
      assert bangumi.episodesCount == 43
      assert bangumi.bgPhoto == "some updated bgPhoto"
      assert bangumi.refreshTag == "some updated refreshTag"
      assert bangumi.summary == "some updated summary"
      assert bangumi.subtype == "some updated subtype"
      assert bangumi.genres == "some updated genres"
      assert bangumi.recentUpdateTime == DateTime.from_naive!(~N[2011-05-18T15:01:01.000000Z], "Etc/UTC")
      assert bangumi.originalTitle == "some updated originalTitle"
      assert bangumi.directors == "some updated directors"
      assert bangumi.auditStatusTxt == "some updated auditStatusTxt"
      assert bangumi.subtypeTxt == "some updated subtypeTxt"
      assert bangumi.auditStatus == 43
      assert bangumi.currentSeries == 43
      assert bangumi.currentSeason == 43
      assert bangumi.title == "some updated title"
      assert bangumi.aka == "some updated aka"
      assert bangumi.tags == "some updated tags"
      assert bangumi.languages == "some updated languages"
      assert bangumi.pubYear == "some updated pubYear"
      assert bangumi.mainlandPubdate == "some updated mainlandPubdate"
      assert bangumi.state == 43
      assert bangumi.briefSummary == "some updated briefSummary"
      assert bangumi.refreshTagTxt == "some updated refreshTagTxt"
      assert bangumi.photo == "some updated photo"
      assert bangumi.seasonsCount == 43
      assert bangumi.thumbs == "some updated thumbs"
      assert bangumi.casts == "some updated casts"
      assert bangumi.voId == "some updated voId"
    end

    test "update_bangumi/2 with invalid data returns error changeset" do
      bangumi = bangumi_fixture()
      assert {:error, %Ecto.Changeset{}} = Anime.update_bangumi(bangumi, @invalid_attrs)
      assert bangumi == Anime.get_bangumi!(bangumi.id)
    end

    test "delete_bangumi/1 deletes the bangumi" do
      bangumi = bangumi_fixture()
      assert {:ok, %Bangumi{}} = Anime.delete_bangumi(bangumi)
      assert_raise Ecto.NoResultsError, fn -> Anime.get_bangumi!(bangumi.id) end
    end

    test "change_bangumi/1 returns a bangumi changeset" do
      bangumi = bangumi_fixture()
      assert %Ecto.Changeset{} = Anime.change_bangumi(bangumi)
    end
  end
end
