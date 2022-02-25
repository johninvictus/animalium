defmodule AnimaliumWeb.PokemonQueriesTest do
  use AnimaliumWeb.ConnCase

  test "pokemon_by_name" do
    query = """
    query {
      pokemonByName(name: "Phoenix"){
        id
        name
      }
    }
    """

    conn =
      build_conn()
      |> post("/graph_api", query: query)

    assert %{
             "data" => %{
               "pokemonByName" => %{
                 "id" => "1",
                 "name" => "Phoenix"
               }
             }
           } ==
             json_response(conn, 200)
  end

  test "pokemon_by_id" do
    query = """
      query {
        pokemonById(id: 1){
          id
          name
        }
      }
    """

    conn =
      build_conn()
      |> post("/graph_api", query: query)

    assert %{
             "data" => %{
               "pokemonById" => %{
                 "id" => "1",
                 "name" => "Phoenix"
               }
             }
           } == json_response(conn, 200)
  end
end
