defmodule AnimaliumWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.
  """
  require Logger

  use AnimaliumWeb, :controller

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> render(AnimaliumWeb.ErrorView, :"404")
  end

  def call(conn, {:error, %{message: message, status: status}}) do
    conn
    |> put_status(status)
    |> render(AnimaliumWeb.ErrorView, "error.json", message: message)
  end

  def call(conn, body) do
    Logger.error(body)

    conn
    |> put_status(500)
    |> render(AnimaliumWeb.ErrorView, "error.json", message: "Sorry an error occurred")
  end
end
