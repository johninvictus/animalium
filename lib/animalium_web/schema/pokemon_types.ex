defmodule AnimaliumWeb.Schema.PokemonTypes do
  @moduledoc """
    Defining an Pokemon graghql object
  """
  use Absinthe.Schema.Notation
  alias AnimaliumWeb.Resolvers.PokemonResolver

  @desc "pokemon schema representation"
  object :pokemon do
    field :id, :string
    field :name, :string
  end

  @doc "pokemon queries"
  object :pokemon_queries do
    @desc "get pokemon object by providing it name"
    field :pokemon_by_name, :pokemon do
      arg(:name, non_null(:string))

      resolve(&PokemonResolver.pokemon_by_name/3)
    end

    @desc "get pokemon object by providing it ID"
    field :pokemon_by_id, :pokemon do
      arg(:id, non_null(:integer))
      resolve(&PokemonResolver.pokemon_by_id/3)
    end
  end
end
