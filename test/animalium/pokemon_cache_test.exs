defmodule Animalium.PokemonCacheTest do
  use Animalium.DataCase, async: true

  alias Animalium.PokemonCache

  @receive_timeout 1000

  setup_all do
    # start Application instance, this will ensure the GenServers are started
    PokemonCache.start_link([])
    :ok
  end

  test "add_pokemon/2" do
    pokemon = %{id: 2, name: "rockers"}
    test_process = self()
    assert PokemonCache.add_pokemon(pokemon, test_process) == :ok
    assert_receive :done, @receive_timeout
  end

  test "get_pokemon_by_id/1" do
    pokemon = %{id: 100, name: "ix"}
    test_process = self()
    assert PokemonCache.add_pokemon(pokemon, test_process) == :ok

    # wait for cache to be store
    # make sure the work is done before requesting cache
    assert_receive :done, @receive_timeout

    assert {:ok, ^pokemon} = PokemonCache.get_pokemon_by_id(pokemon.id)
    assert {:error, :not_found} = PokemonCache.get_pokemon_by_id(pokemon.id + 1)
  end

  test "get_pokemon_by_name/1" do
    pokemon = %{id: 100, name: "ix"}
    assert PokemonCache.add_pokemon(pokemon, self()) == :ok

    assert_receive :done, @receive_timeout

    # wait for cache to be store
    assert {:ok, ^pokemon} = PokemonCache.get_pokemon_by_name(pokemon.name)
    assert {:error, :not_found} = PokemonCache.get_pokemon_by_name("pok")
  end
end
