ExUnit.start(exclude: [:skip])
# Ecto.Adapters.SQL.Sandbox.mode(Animalium.Repo, :manual)
Ecto.Adapters.SQL.Sandbox.mode(Animalium.Repo, {:shared, self()})
