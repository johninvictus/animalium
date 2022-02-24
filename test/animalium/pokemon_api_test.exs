defmodule Animalium.API.PokemonAPITest do
  use Animalium.DataCase

  alias Animalium.API.PokemonAPI

  @pokemons [
    %{"id" => 1, "name" => "Phoenix"},
    %{"id" => 2, "name" => "Pikachu"},
    %{"id" => 3, "name" => "Eevee"},
    %{"id" => 4, "name" => "Alcremie"},
  ]

  setup do
    Tesla.Mock.mock(fn
      %{method: :get, url: "https://pokeapi.co/api/v2/pokemon/" <> value} ->
       @pokemons
        |> Enum.filter(fn %{"id" => id, "name" => name} ->
          to_string(id) == value ||  name == value
        end)
        |> case do
          [pokemon | []] ->
            %Tesla.Env{status: 200, body: pokemon }

          [] ->   %Tesla.Env{status: 400, body: %{} }
        end
    end)

    :ok
  end

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
