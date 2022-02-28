defmodule Animalium.TestAPITest do
  @moduledoc false
  use Animalium.DataCase, async: true

  import Mox

 alias Animalium.TestAPI

 @not_found "Not found"

  test "get_by_id/1 - 200" do
    PokemonAPIMock
    |> expect(:fetch_content, fn id ->
      {:ok, %Tesla.Env{status: 200, body: %{"id" => String.to_integer(id), "name" => "Phoenix"}}}
    end)


    assert "Phoenix" = TestAPI.get_by_id(1)
  end

  test "get_by_id/1 - 404" do
    PokemonAPIMock
    |> expect(:fetch_content, fn _id ->
      {:ok, %Tesla.Env{status: 404, body:  @not_found}}
    end)

    assert @not_found == TestAPI.get_by_id(1)
  end

  test "get_by_name/1 - 200" do
    name = "Phoenix"

    PokemonAPIMock
    |> expect(:fetch_content, fn ^name  ->
      {:ok, %Tesla.Env{status: 200, body:  %{"id" => 1, "name" => name}}}
    end)

    assert 1 == TestAPI.get_by_name(name)
  end

  test "get_by_name/1 - 404" do
    name = "Phoenix"

    PokemonAPIMock
    |> expect(:fetch_content, fn ^name  ->
      {:ok, %Tesla.Env{status: 404, body:  @not_found}}
    end)

    assert @not_found == TestAPI.get_by_name(name)
  end
end
