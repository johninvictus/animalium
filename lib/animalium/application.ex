defmodule Animalium.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Animalium.Repo,
      # Start the Telemetry supervisor
      AnimaliumWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Animalium.PubSub},
      # Start the Endpoint (http/https)
      AnimaliumWeb.Endpoint,
      Animalium.PokemonCache
      # Start a worker by calling: Animalium.Worker.start_link(arg)
      # {Animalium.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Animalium.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AnimaliumWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
