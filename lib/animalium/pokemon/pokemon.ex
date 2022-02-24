defmodule Animalium.Pokemon do
  @moduledoc """
  Make request to API with Pokemon path
  """
  use Animalium.BaseApi, path: "pokemon"


  @doc """
   Will return pokemon if provided an id
  """
  def get_by_id(id) do
    id
    |> to_string()
    |> get_pokemon()
  end

  @doc """
  Will return pokemon when the name is provided
  """
  def get_by_name(name) when is_binary(name), do: get_pokemon(name)

  defp get_pokemon(id_or_name) when is_binary(id_or_name) do
    id_or_name
    |> get()
    |> process_result()
  end

  defp get_pokemon(_), do: {:error, "please use a string parameter"}
end
