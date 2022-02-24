defmodule AnimaliumWeb.PageController do
  use AnimaliumWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
