defmodule MoelabServer.AnimeTest do
  use MoelabServer.DataCase

  alias MoelabServer.Anime

  describe "bangumi" do
    alias MoelabServer.Anime.Bangumi

    @valid_attrs %{
      voId: "some voId",
      casts: "some casts",
      thumbs: "some thumbs",
      seasonsCount: 42,
      photo: "some photo",
      refreshTagTxt: "some refreshTagTxt",
      briefSummary: "some briefSummary",
      state: 42,
      mainlandPubdate: "some mainlandPubdate",
      pubYear: "some pubYear",
      languages: "some languages",
      tags: "some tags",
      aka: "some aka",
      title: "some title",
      currentSeason: 42,
      currentSeries: 42,
      auditStatus: 42,
      subtypeTxt: "some subtypeTxt",
      auditStatusTxt: "some auditStatusTxt",
      directors: "some directors",
      originalTitle: "some originalTitle",
      recentUpdateTime: "2010-04-17T14:00:00.000000Z",
      genres: "some genres",
      subtype: "some subtype",
      summary: "some summary",
      refreshTag: "some refreshTag",
      bgPhoto: "some bgPhoto",
      episodesCount: 42,
      tagsTxt: "some tagsTxt",
      rgb: "some rgb",
      rating: 120.5,
      countries: "some countries",
      stateTxt: "some stateTxt"
    }
    @update_attrs %{
      voId: "some updated voId",
      casts: "some updated casts",
      thumbs: "some updated thumbs",
      seasonsCount: 43,
      photo: "some updated photo",
      refreshTagTxt: "some updated refreshTagTxt",
      briefSummary: "some updated briefSummary",
      state: 43,
      mainlandPubdate: "some updated mainlandPubdate",
      pubYear: "some updated pubYear",
      languages: "some updated languages",
      tags: "some updated tags",
      aka: "some updated aka",
      title: "some updated title",
      currentSeason: 43,
      currentSeries: 43,
      auditStatus: 43,
      subtypeTxt: "some updated subtypeTxt",
      auditStatusTxt: "some updated auditStatusTxt",
      directors: "some updated directors",
      originalTitle: "some updated originalTitle",
      recentUpdateTime: "2011-05-18T15:01:01.000000Z",
      genres: "some updated genres",
      subtype: "some updated subtype",
      summary: "some updated summary",
      refreshTag: "some updated refreshTag",
      bgPhoto: "some updated bgPhoto",
      episodesCount: 43,
      tagsTxt: "some updated tagsTxt",
      rgb: "some updated rgb",
      rating: 456.7,
      countries: "some updated countries",
      stateTxt: "some updated stateTxt"
    }
    @invalid_attrs %{
      voId: nil,
      casts: nil,
      thumbs: nil,
      seasonsCount: nil,
      photo: nil,
      refreshTagTxt: nil,
      briefSummary: nil,
      state: nil,
      mainlandPubdate: nil,
      pubYear: nil,
      languages: nil,
      tags: nil,
      aka: nil,
      title: nil,
      currentSeason: nil,
      currentSeries: nil,
      auditStatus: nil,
      subtypeTxt: nil,
      auditStatusTxt: nil,
      directors: nil,
      originalTitle: nil,
      recentUpdateTime: nil,
      genres: nil,
      subtype: nil,
      summary: nil,
      refreshTag: nil,
      bgPhoto: nil,
      episodesCount: nil,
      tagsTxt: nil,
      rgb: nil,
      rating: nil,
      countries: nil,
      stateTxt: nil
    }

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

      assert bangumi.recentUpdateTime ==
               DateTime.from_naive!(~N[2010-04-17T14:00:00.000000Z], "Etc/UTC")

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

      assert bangumi.recentUpdateTime ==
               DateTime.from_naive!(~N[2011-05-18T15:01:01.000000Z], "Etc/UTC")

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

  describe "genres" do
    alias MoelabServer.Anime.Genre

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def genre_fixture(attrs \\ %{}) do
      {:ok, genre} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Anime.create_genre()

      genre
    end

    test "list_genres/0 returns all genres" do
      genre = genre_fixture()
      assert Anime.list_genres() == [genre]
    end

    test "get_genre!/1 returns the genre with given id" do
      genre = genre_fixture()
      assert Anime.get_genre!(genre.id) == genre
    end

    test "create_genre/1 with valid data creates a genre" do
      assert {:ok, %Genre{} = genre} = Anime.create_genre(@valid_attrs)
      assert genre.name == "some name"
    end

    test "create_genre/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Anime.create_genre(@invalid_attrs)
    end

    test "update_genre/2 with valid data updates the genre" do
      genre = genre_fixture()
      assert {:ok, %Genre{} = genre} = Anime.update_genre(genre, @update_attrs)
      assert genre.name == "some updated name"
    end

    test "update_genre/2 with invalid data returns error changeset" do
      genre = genre_fixture()
      assert {:error, %Ecto.Changeset{}} = Anime.update_genre(genre, @invalid_attrs)
      assert genre == Anime.get_genre!(genre.id)
    end

    test "delete_genre/1 deletes the genre" do
      genre = genre_fixture()
      assert {:ok, %Genre{}} = Anime.delete_genre(genre)
      assert_raise Ecto.NoResultsError, fn -> Anime.get_genre!(genre.id) end
    end

    test "change_genre/1 returns a genre changeset" do
      genre = genre_fixture()
      assert %Ecto.Changeset{} = Anime.change_genre(genre)
    end
  end

  describe "tags" do
    alias MoelabServer.Anime.Tag

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def tag_fixture(attrs \\ %{}) do
      {:ok, tag} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Anime.create_tag()

      tag
    end

    test "list_tags/0 returns all tags" do
      tag = tag_fixture()
      assert Anime.list_tags() == [tag]
    end

    test "get_tag!/1 returns the tag with given id" do
      tag = tag_fixture()
      assert Anime.get_tag!(tag.id) == tag
    end

    test "create_tag/1 with valid data creates a tag" do
      assert {:ok, %Tag{} = tag} = Anime.create_tag(@valid_attrs)
      assert tag.name == "some name"
    end

    test "create_tag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Anime.create_tag(@invalid_attrs)
    end

    test "update_tag/2 with valid data updates the tag" do
      tag = tag_fixture()
      assert {:ok, %Tag{} = tag} = Anime.update_tag(tag, @update_attrs)
      assert tag.name == "some updated name"
    end

    test "update_tag/2 with invalid data returns error changeset" do
      tag = tag_fixture()
      assert {:error, %Ecto.Changeset{}} = Anime.update_tag(tag, @invalid_attrs)
      assert tag == Anime.get_tag!(tag.id)
    end

    test "delete_tag/1 deletes the tag" do
      tag = tag_fixture()
      assert {:ok, %Tag{}} = Anime.delete_tag(tag)
      assert_raise Ecto.NoResultsError, fn -> Anime.get_tag!(tag.id) end
    end

    test "change_tag/1 returns a tag changeset" do
      tag = tag_fixture()
      assert %Ecto.Changeset{} = Anime.change_tag(tag)
    end
  end
end
