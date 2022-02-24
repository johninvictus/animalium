defmodule AnimaliumWeb.Resolvers.PokemonResolver do
  @moduledoc """
  Resolve Pokemon
  """

  alias Animalium.PokemonRepo

  def pokemon_by_name(_parent, %{name: name}, _context) do
    PokemonRepo.get_pokemon_by_name(name)
  end

  def pokemon_by_id(_parent, %{id: id}, _context) do
    PokemonRepo.get_pokemon_by_id(id)
  end
end
