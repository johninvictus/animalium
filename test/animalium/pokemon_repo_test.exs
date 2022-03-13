defmodule Animalium.PokemonRepoTest do
  use Animalium.DataCase, async: true

  import Hammox

  alias Animalium.PokemonRepo


  test "get_pokemon_by_name/1" do
    PokemonAPIMock
    |> expect(:fetch_content, fn name  ->
      {:ok, %Tesla.Env{status: 200, body:  %{"id" => 1, "name" => name}}}
    end)

    name = "Phoenix"
    assert {:ok, pokemon} = PokemonRepo.get_pokemon_by_name(name)
    assert pokemon.name == name
  end


  test "get_pokemon_by_id/1" do
    id = 1

    PokemonAPIMock
    |> expect(:fetch_content, fn id  ->
      {:ok, %Tesla.Env{status: 200, body:  %{"id" => String.to_integer(id), "name" => "Phoenix"}}}
    end)

    assert {:ok, pokemon} = PokemonRepo.get_pokemon_by_id(id)
    assert pokemon.id == id
  end
end
