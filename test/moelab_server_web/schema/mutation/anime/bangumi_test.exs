defmodule MoelabServerWeb.Schema.Mutation.Anime.BangumiTest do
  use MoelabServerWeb.ConnCase, async: true

  alias Helper.ORM
  alias MoelabServer.Anime.Bangumi

  @query """
  mutation {
    createBangumi(input: {bgPhoto: "Some Photo", currentSeason: 0, state: 0, casts: "Some Casts", pubYear: "1999", title: "Some title", originalTitle: "Some title", mainlandPubdate: "2019", briefSummary: "Some Summary", aka: "Some aka", rgb: "rgb", photo: "Some Photo", refreshTag: "7", currentSeries: 872.0, seasonsCount: 0, directors: "Some Directors", summary: "Some Summary", languages: "English", rating: 9.5, episodesCount: 666, countries: "USA", id: 1, auditStatus: 3, subtype: "animation", vo_id: "Some VoId"}) {
      title
    }
  }
  """
  test "create a bangumi", %{conn: conn} do
    response =
      post(conn, "/api", %{
        query: @query
      })

    assert %{
             "data" => %{
               "createBangumi" => %{
                 "title" => title
               }
             }
           } = json_response(response, 200)

    assert "Some title" == title
  end

  @query """
  mutation ($id: ID!) {
    updateBangumi (id: $id, input: {bgPhoto: "Some Photo", currentSeason: 0, state: 0, casts: "Some Casts", pubYear: "1999", title: "Some new title", originalTitle: "Some title", mainlandPubdate: "2019", briefSummary: "Some Summary", aka: "Some aka", rgb: "rgb", photo: "Some Photo", refreshTag: "7", currentSeries: 872.0, seasonsCount: 0, directors: "Some Directors", summary: "Some Summary", languages: "English", rating: 9.5, episodesCount: 666, countries: "USA", auditStatus: 3, subtype: "animation", vo_id: "Some VoId"}) {
      title
    }
  }
  """
  test "update a bangumi", %{conn: conn} do
    bangumi = Factory.create_bangumi()

    response =
      post(conn, "/api", %{
        query: @query,
        variables: %{"id" => bangumi.id}
      })

    assert %{
             "data" => %{
               "updateBangumi" => %{
                 "title" => title
               }
             }
           } = json_response(response, 200)

    assert "Some new title" == title
  end

  @query """
  mutation ($id: ID!) {
    deleteBangumi (id: $id) {
      id
    }
  }
  """
  test "delete a bangumi", %{conn: conn} do
    bangumi = Factory.create_bangumi()

    response =
      post(conn, "/api", %{
        query: @query,
        variables: %{"id" => bangumi.id}
      })

    assert %{
             "data" => %{
               "deleteBangumi" => %{
                 "id" => id
               }
             }
           } = json_response(response, 200)

    assert id == to_string(bangumi.id)
    assert {:error, _} = ORM.find(Bangumi, bangumi.id)
  end
end
