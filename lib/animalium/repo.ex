defmodule Animalium.Repo do
  use Ecto.Repo,
    otp_app: :animalium,
    adapter: Ecto.Adapters.Postgres

  @doc "will return success or error tuple"
  @spec result(any()) :: {:ok, map()} | {:error, :not_found}
  def result(nil), do: {:error, :not_found}

  def result(%{} = result), do: {:ok, result}
end
