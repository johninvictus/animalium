defmodule Animalium.API.PokemonAPITest do
  use Animalium.DataCase

  alias Animalium.API.PokemonAPI

  test "get_by_id/1" do
    id = 1
    {:ok, pokemon} = PokemonAPI.get_by_id(id)
    assert pokemon.id == id
  end

  test "get_by_name/1" do
    name = "Phoenix"
    {:ok, pokemon} = PokemonAPI.get_by_name(name)
    assert pokemon.name == name
  end
end
