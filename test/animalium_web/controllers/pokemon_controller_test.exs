defmodule AnimaliumWeb.PokemonControllerTest do
  use AnimaliumWeb.ConnCase, async: true

  test "GET /pokemon_by_name" do
    conn = build_conn()
    conn = get conn, Routes.pokemon_path(conn, :by_name, %{"name" => "Phoenix"})

    assert json_response(conn, 200) == %{"id" => 1, "name" => "Phoenix"}
  end


  test "GET /pokemon_by_id" do
    conn = build_conn()
    conn = get conn, Routes.pokemon_path(conn, :by_id, %{"id" => 1})

    assert json_response(conn, 200) == %{"id" => 1, "name" => "Phoenix"}
  end

end
