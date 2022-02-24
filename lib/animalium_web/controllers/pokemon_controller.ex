defmodule AnimaliumWeb.PokemonController do
  use AnimaliumWeb, :controller

  alias Animalium.PokemonRepo

  action_fallback(AnimaliumWeb.FallbackController)

  def by_name(conn, %{"name" => name}) do
    with {:ok, pokemon} <- PokemonRepo.get_pokemon_by_name(name) do
      json(conn, pokemon)
    end
  end

  def by_id(conn, %{"id" => id}) do
    with {:ok, pokemon} <- PokemonRepo.get_pokemon_by_id(String.to_integer(id)) do
      json(conn, pokemon)
    end
  end
end
