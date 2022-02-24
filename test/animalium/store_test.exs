defmodule Animalium.StoreTest do
  use Animalium.DataCase

  alias Animalium.Store

  describe "pokemons" do
    alias Animalium.Store.Pokemon

    import Animalium.StoreFixtures

    @invalid_attrs %{id: nil, name: nil}

    test "list_pokemons/0 returns all pokemons" do
      pokemon = pokemon_fixture()
      assert Store.list_pokemons() == [pokemon]
    end

    test "get_pokemon!/1 returns the pokemon with given id" do
      pokemon = pokemon_fixture()
      assert Store.get_pokemon!(pokemon.id) == pokemon
    end

    test "get_pokemon/1 returns the pokemon with given id" do
      pokemon = pokemon_fixture()
      assert Store.get_pokemon(pokemon.id) == pokemon
      assert Store.get_pokemon(pokemon.id+1) == nil
    end

    test "get_pokemon_by_name/1 returns the pokemon with given name" do
      pokemon = pokemon_fixture()
      assert Store.get_pokemon_by_name(pokemon.name) == pokemon
      assert Store.get_pokemon_by_name("magic") == nil
    end

    test "create_pokemon/1 with valid data creates a pokemon" do
      valid_attrs = %{id: 42, name: "some name"}

      assert {:ok, %Pokemon{} = pokemon} = Store.create_pokemon(valid_attrs)
      assert pokemon.id == 42
      assert pokemon.name == "some name"
    end

    test "create_pokemon/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Store.create_pokemon(@invalid_attrs)
    end

    test "update_pokemon/2 with valid data updates the pokemon" do
      pokemon = pokemon_fixture()
      update_attrs = %{id: 43, name: "some updated name"}

      assert {:ok, %Pokemon{} = pokemon} = Store.update_pokemon(pokemon, update_attrs)
      assert pokemon.id == 43
      assert pokemon.name == "some updated name"
    end

    test "update_pokemon/2 with invalid data returns error changeset" do
      pokemon = pokemon_fixture()
      assert {:error, %Ecto.Changeset{}} = Store.update_pokemon(pokemon, @invalid_attrs)
      assert pokemon == Store.get_pokemon!(pokemon.id)
    end

    test "delete_pokemon/1 deletes the pokemon" do
      pokemon = pokemon_fixture()
      assert {:ok, %Pokemon{}} = Store.delete_pokemon(pokemon)
      assert_raise Ecto.NoResultsError, fn -> Store.get_pokemon!(pokemon.id) end
    end

    test "change_pokemon/1 returns a pokemon changeset" do
      pokemon = pokemon_fixture()
      assert %Ecto.Changeset{} = Store.change_pokemon(pokemon)
    end
  end
end
