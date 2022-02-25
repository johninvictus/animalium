defmodule Animalium.PokemonRepoTest do
  use Animalium.DataCase, async: true

  alias Animalium.PokemonRepo

  test "get_pokemon_by_name/1" do
    name = "Phoenix"
    assert {:ok, pokemon} = PokemonRepo.get_pokemon_by_name(name)
    assert pokemon.name == name
  end

  test "get_pokemon_by_id/1" do
    id = 1
    assert {:ok, pokemon} = PokemonRepo.get_pokemon_by_id(id)
    assert pokemon.id == id
  end
end
