defmodule Animalium.PokemonCacheTest do
  use Animalium.DataCase, async: true

  alias Animalium.PokemonCache

  setup_all do
    # start Application instance, this will ensure the GenServers are started
    PokemonCache.start_link([])
    :ok
  end

  test "add_pokemon/1" do
    pokemon = %{id: 2, name: "rockers"}
    assert PokemonCache.add_pokemon(pokemon) == :ok

    # Hack to make sure postgres connection completes before GenServer dies
    Process.sleep(100)
  end

  test "get_pokemon_by_id/1" do
    pokemon = %{id: 100, name: "ix"}
    assert PokemonCache.add_pokemon(pokemon) == :ok

    # wait for cache to be store
    Process.sleep(10)
    assert {:ok, ^pokemon} = PokemonCache.get_pokemon_by_id(pokemon.id)
    assert {:error, :not_found} = PokemonCache.get_pokemon_by_id(pokemon.id + 1)

    Process.sleep(100)
  end

  test "get_pokemon_by_name/1" do
    pokemon = %{id: 100, name: "ix"}
    assert PokemonCache.add_pokemon(pokemon) == :ok

    # wait for cache to be store
    Process.sleep(10)
    assert {:ok, ^pokemon} = PokemonCache.get_pokemon_by_name(pokemon.name)
    assert {:error, :not_found} = PokemonCache.get_pokemon_by_name("pok")

    Process.sleep(100)
  end
end
