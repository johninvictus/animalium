defmodule Animalium.PokemonCache do
  @moduledoc """
   This module will cache pokemons
  """
  use GenServer
  alias Animalium.{Store, Repo}
  alias Animalium.Store.Pokemon

  require Logger

  def start_link(params) do
    GenServer.start_link(__MODULE__, params, name: __MODULE__)
  end

  @doc "add pokemon to cache"
  @spec add_pokemon(Pokemon.t()) :: :ok
  def add_pokemon(%Pokemon{name: _, id: _} = pokemon) do
    GenServer.cast(__MODULE__, {:add_pokemon, pokemon})
  end


  @doc "get pokemon by id"
  @spec get_pokemon_by_id(binary()) :: {:ok, map()} | {:error, :not_found}
  def get_pokemon_by_id(id) do
    with {:error, :not_found} <- get_ets_pokemon(id),
    {:ok, pokemon} <- Repo.result(Store.get_pokemon(id)) do
        add_pokemon(pokemon)
      {:ok, pokemon}
    end
  end


  @doc "get pokemon by it name"
  def get_pokemon_by_name(name) do
    with {:error, :not_found} <- get_ets_pokemon(name),
    {:ok, pokemon} <- Repo.result(Store.get_pokemon_by_name(name)) do
        add_pokemon(pokemon)
      {:ok, pokemon}
    end
  end

  @impl GenServer
  def init(_) do
    # start an ETS instance for in memory cache
    :ets.new(ets_table(), [:ordered_set, :protected, :named_table])

    {:ok, %{}}
  end

  @impl GenServer
  def handle_cast({:add_pokemon, pokemon}, state) do
    # store to ets
    :ets.insert(ets_table(), {pokemon.id, pokemon})
    # store using name
    :ets.insert(ets_table(), {pokemon.name, pokemon})

    # store to postgres
    Store.create_pokemon(pokemon)

    {:noreply, state}
  end

  defp ets_table, do: :pokemons

  defp get_ets_pokemon(key) do
    ets_table()
    |> :ets.lookup(key)
    |> case do
      [{^key, value} | _] ->
        {:ok, value}

      _ ->
        {:error, :not_found}
    end
  end
end
