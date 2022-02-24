defmodule AnimaliumWeb.Schema do
  @moduledoc """
    GraphQl Schema for exposing our queries, mutations and subscriptions
  """

  use Absinthe.Schema

  import_types(__MODULE__.PokemonTypes)

  @desc "The root query type which gives access points into the available data."
  query name: "Query" do
    import_fields(:pokemon_queries)
  end
end
