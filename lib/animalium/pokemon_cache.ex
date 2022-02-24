defmodule Animalium.PokemonCache do
  @moduledoc """
   This module will cache pokemons
  """
  use GenServer
  alias Animalium.{Store, Repo}

  require Logger

  def start_link(params) do
    GenServer.start_link(__MODULE__, params, name: __MODULE__)
  end

  @doc "add pokemon to cache"
  @spec add_pokemon(map()) :: :ok
  def add_pokemon(%{name: name, id: id}) do
    GenServer.cast(__MODULE__, {:add_pokemon, %{name: name, id: id}})
  end

  @doc "get pokemon by id"
  @spec get_pokemon_by_id(integer()) :: {:ok, map()} | {:error, :not_found}
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
    # only genserver will be able to write ETS (:protected)
    :ets.new(ets_table(), [:ordered_set, :protected, :named_table])
    {:ok, %{}}
  end

  @impl GenServer
  def handle_cast({:add_pokemon, pokemon}, state) do
    # add to ets if empty
    add_pokemon_to_ets(pokemon)
    # add to database if empty
    add_pokemon_to_db(pokemon)

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

  defp add_pokemon_to_ets(pokemon) do
    with {:error, :not_found} <- get_ets_pokemon(pokemon.id) do
      # store to ets
      :ets.insert(ets_table(), {pokemon.id, pokemon})
      # store using name
      :ets.insert(ets_table(), {pokemon.name, pokemon})
      {:ok, pokemon}
    end
  end

  defp add_pokemon_to_db(pokemon) do
    with {:error, :no_found} <- Repo.result(Store.get_pokemon(pokemon.id)) do
      # store to postgres
      Store.create_pokemon(pokemon)
    end
  end
end
