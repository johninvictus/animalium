defmodule TeslaMock do
  @pokemons [
    %{"id" => 1, "name" => "Phoenix"},
    %{"id" => 2, "name" => "Pikachu"},
    %{"id" => 3, "name" => "Eevee"},
    %{"id" => 4, "name" => "Alcremie"}
  ]

  def mock do
    Tesla.Mock.mock(fn
      %{method: :get, url: "https://pokeapi.co/api/v2/pokemon/" <> value} ->
        @pokemons
        |> Enum.filter(fn %{"id" => id, "name" => name} ->
          to_string(id) == value || name == value
        end)
        |> case do
          [pokemon | []] ->
            %Tesla.Env{status: 200, body: pokemon}

          [] ->
            %Tesla.Env{status: 400, body: %{}}
        end
    end)
  end
end
