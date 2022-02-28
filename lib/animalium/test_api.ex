defmodule Animalium.TestAPI do
  @moduledoc """
   This module will return data as described by the Assignment

   ie
   Build an Elixir app that will retrieve the name of the Pokemon
   if I give it an ID or the ID of a Pokemon if I give it a name
  (Example input output: "ditto" -> "132", "139" -> "omastar", "9999" -> "not found").
  """

  alias Animalium.API.PokemonAPI

  @doc """
  Will return a pokemon name or a not found message
  """
  @spec get_by_id(integer()) :: binary()
  def get_by_id(id) do
    PokemonAPI.get_by_id(id)
    |> case do
      {:ok, pokemon} -> pokemon.name
      {:error, %{message: message}} -> message
    end
  end


   @doc """
  Will return a pokemon name or a not found message
  """
  @spec get_by_name(binary()) :: binary()
  def get_by_name(name) do
    PokemonAPI.get_by_name(name)
    |> case do
      {:ok, pokemon} -> pokemon.id
      {:error, %{message: message}} -> message
    end
  end


end
