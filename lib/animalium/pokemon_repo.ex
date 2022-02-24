defmodule Animalium.PokemonRepo do
  @moduledoc """
  This module will encapsulate where data is coming from
  """
  alias Animalium.PokemonCache
  alias Animalium.API.PokemonAPI

  @doc """
  Will return Pokemon when name is provided
  """
  def get_pokemon_by_name(name) do
    with {:error, :not_found} <- PokemonCache.get_pokemon_by_name(name),
         {:ok, pokemon} <- PokemonAPI.get_by_name(name),
          :ok <- PokemonCache.add_pokemon(pokemon) do
      {:ok, pokemon}
    end
  end


  @doc """
  Will return Pokemon when id is provided
  """
  def get_pokemon_by_id(id) do
    with {:error, :not_found} <- PokemonCache.get_pokemon_by_id(id),
         {:ok, pokemon} <- PokemonAPI.get_by_id(id),
         :ok <- PokemonCache.add_pokemon(pokemon) do
      {:ok, pokemon}
    end
  end

end
