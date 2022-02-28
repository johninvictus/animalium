defmodule AnimaliumWeb.PokemonQueriesTest do
  use AnimaliumWeb.ConnCase, sync: true

  import Mox

  # @tag :skip
  test "pokemon_by_name" do
    PokemonAPIMock
    |> expect(:fetch_content, fn name  ->
      {:ok, %Tesla.Env{status: 200, body:  %{"id" => 1, "name" => name}}}
    end)


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

  # @tag :skip
  test "pokemon_by_id" do

    PokemonAPIMock
    |> expect(:fetch_content, fn id ->
      {:ok, %Tesla.Env{status: 200, body: %{"id" => String.to_integer(id), "name" => "Phoenix"}}}
    end)

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
