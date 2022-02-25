ExUnit.start()
# Ecto.Adapters.SQL.Sandbox.mode(Animalium.Repo, :manual)
Ecto.Adapters.SQL.Sandbox.mode(Animalium.Repo, {:shared, self()})
