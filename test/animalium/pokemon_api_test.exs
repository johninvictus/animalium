defmodule Animalium.API.PokemonAPITest do
  use Animalium.DataCase, async: true

  alias Animalium.API.PokemonAPI

  test "get_by_id/1" do
    id = 1
    {:ok, pokemon} = PokemonAPI.get_by_id(id)
    assert pokemon.id == id

    # unknown id
    {:error, %{message: "Not found", status: 404}} = PokemonAPI.get_by_id(200)
  end

  test "get_by_name/1" do
    name = "Phoenix"
    {:ok, pokemon} = PokemonAPI.get_by_name(name)
    assert pokemon.name == name
  end
end
