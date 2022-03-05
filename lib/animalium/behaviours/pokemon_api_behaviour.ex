defmodule Animalium.Behaviour.PokemonAPIBehaviour do
  @moduledoc """
   Used for testing
  """
  @callback fetch_content(String.t()) ::  {:ok, %Tesla.Env{}} | {:error, any}
end
