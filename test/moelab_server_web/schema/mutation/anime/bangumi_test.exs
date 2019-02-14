defmodule MoelabServerWeb.Schema.Mutation.Anime.BangumiTest do
  use MoelabServerWeb.ConnCase, async: true

  @query """
  mutation {
    createBangumi(input: {bgPhoto: "http://img.neets.cc/video/9b19b45377054c8ebc8eeec9a0f76ed6/large.jpg?x-oss-process=style/bgWebp", voId: "9b19b45377054c8ebc8eeec9a0f76ed6", currentSeason: 0, state: 0, casts: "中井和哉,田中真弓,冈村明美,平田广明", pubYear: "1999", title: "海贼王", originalTitle: "ワンピース", mainlandPubdate: "1999-10-20(日本)", briefSummary: "one piece", aka: "航海王,one piece", rgb: "b9b974", photo: "http://img.neets.cc/video/9b19b45377054c8ebc8eeec9a0f76ed6/large.jpg?x-oss-process=style/normalWebp", refreshTag: "7", currentSeries: 872.0, seasonsCount: 0, directors: "", summary: "one piece", languages: "日语", rating: 9.5, episodesCount: 999, countries: "日本", id: 1, auditStatus: 3, subtype: "animation"}) {
      title
    }
  }
  """
  test "creating an bangumi", %{conn: conn} do
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

    assert "海贼王" == title
  end
end
