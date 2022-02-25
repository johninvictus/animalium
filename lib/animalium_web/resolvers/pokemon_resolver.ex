defmodule AnimaliumWeb.Resolvers.PokemonResolver do
  @moduledoc """
  Resolve Pokemon
  """

  alias Animalium.PokemonRepo

  @type pokemon_t() :: {:ok, map()} | {:error, String.t() | map()}

  @spec pokemon_by_name(any(), map(), map()) :: pokemon_t()
  def pokemon_by_name(_parent, %{name: name}, _context) do
    PokemonRepo.get_pokemon_by_name(name)
  end

  @spec pokemon_by_id(any(), map(), map()) :: pokemon_t()
  def pokemon_by_id(_parent, %{id: id}, _context) do
    PokemonRepo.get_pokemon_by_id(id)
  end
end
