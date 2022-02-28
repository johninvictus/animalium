defmodule Animalium.API.PokemonAPITest do
  use Animalium.DataCase, async: true

  alias Animalium.API.PokemonAPI

  import Mox

  test "get_by_id/1 - 200" do
    PokemonAPIMock
    |> expect(:fetch_content, fn id  ->
      {:ok, %Tesla.Env{status: 200, body:  %{"id" => String.to_integer(id), "name" => "Phoenix"}}}
    end)

    id = 1
    {:ok, pokemon} = PokemonAPI.get_by_id(id)
    assert pokemon.id == id


  end


  test "get_by_id/1 - 404" do
    PokemonAPIMock
    |> expect(:fetch_content, fn _id  ->
      {:ok, %Tesla.Env{status: 404, body: "Not found"}}
    end)

    {:error, %{message: "Not found", status: 404}} = PokemonAPI.get_by_id(200)
  end


  test "get_by_name/1" do
    name = "Phoenix"

    PokemonAPIMock
    |> expect(:fetch_content, fn ^name  ->
      {:ok, %Tesla.Env{status: 200, body:  %{"id" => 1, "name" => name}}}
    end)


    {:ok, pokemon} = PokemonAPI.get_by_name(name)
    assert pokemon.name == name
  end
end
