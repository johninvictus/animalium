defmodule Animalium.StoreFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Animalium.Store` context.
  """

  @doc """
  Generate a pokemon.
  """
  def pokemon_fixture(attrs \\ %{}) do
    {:ok, pokemon} =
      attrs
      |> Enum.into(%{
        id: 42,
        name: "some name"
      })
      |> Animalium.Store.create_pokemon()

    pokemon
  end
end
