defmodule Animalium.API.PokemonAPI do
  @moduledoc """
  Make request to API with Pokemon path
  """
  use Animalium.BaseAPI, path: "pokemon"

  alias Animalium.Behaviour.PokemonAPIBehaviour

  @behaviour Animalium.Behaviour.PokemonAPIBehaviour

  @http_adapter Application.get_env(:animalium, :http_adapter, Animalium.API.PokemonAPI)

  @doc """
   Will return pokemon if provided an id
  """
  @spec get_by_id(integer()) :: response()
  def get_by_id(id) do
    id
    |> to_string()
    |> get_pokemon()
  end

  @doc """
  Will return pokemon when the name is provided
  """
  @spec get_by_name(binary()) :: response()
  def get_by_name(name) when is_binary(name), do: get_pokemon(name)

  @impl PokemonAPIBehaviour
  def fetch_content(path) do
    __MODULE__.get(path)
  end

  defp get_pokemon(id_or_name) when is_binary(id_or_name) do
    id_or_name
    |> @http_adapter.fetch_content()
    |> process_result()
  end

  defp get_pokemon(_), do: {:error, "please use a string parameter"}
end
