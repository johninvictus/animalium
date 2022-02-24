defmodule Animalium.Repo.Migrations.CreatePokemons do
  use Ecto.Migration

  def change do
    create table(:pokemons, primary_key: false) do
      add :id, :integer, primary_key: true
      add :name, :string

      timestamps()
    end
  end
end
