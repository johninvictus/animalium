defmodule Animalium.Repo do
  use Ecto.Repo,
    otp_app: :animalium,
    adapter: Ecto.Adapters.Postgres
end
