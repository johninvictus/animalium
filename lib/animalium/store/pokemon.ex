defmodule Animalium.Store.Pokemon do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "pokemons" do
    field :id, :integer, primary_key: true
    field :name, :string
  end

  @doc false
  def changeset(pokemon, attrs) do
    pokemon
    |> cast(attrs, [:id, :name])
    |> validate_required([:id, :name])
  end
end
