defmodule Animalium.BaseApi do
  @moduledoc """
   Base HTTP client to contact Pokemon API
  """

  @doc """
  Macro to act as an entry point to the Pokemon API.

  ## Example

    defmodule Pokemon do
      use Animalium.BaseApi, path: "pokemon"

      def test do
        {:ok, _} = get("/pokemon_id")
      end
    end
  """
  defmacro __using__(opts) do
    quote do
      use Tesla, doc: false

      @config unquote(opts)

      @accept "application/json"
      @content_type "application/x-www-form-urlencoded"
      @base_url Application.get_env(:animalium, :pokemon_base_url)

      plug(Tesla.Middleware.BaseUrl, base_url <> "/" <> @config[:path])

      # The `type` config is to allow the api send `application/json` check https://github.com/teamon/tesla#formats for more info. Needed in requests such as Mobile/checkput
      if @config[:type] && @config[:type] == "json" do
        plug(Tesla.Middleware.JSON)
      else
        plug(Tesla.Middleware.FormUrlencoded)
      end

      plug(Tesla.Middleware.Headers, [
        {"Accept", @accept},
        {"Content-Type", @content_type}
      ])

      @doc """
      Process the results comming from pokemon api
      """
      def process_result({:ok, %{status: status} = res}) when status in [200, 201] do
        if is_map(res.body) do
          {:ok, res.body}
        else
          Jason.decode(res.body)
        end
      end

      def process_result({:ok, result}) do
        {:error, %{status: result.status, message: result.body}}
      end

      def process_result({:error, result}) do
        {:error, result}
      end
    end
  end
end