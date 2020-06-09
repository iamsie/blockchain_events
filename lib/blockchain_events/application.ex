defmodule BlockchainEvents.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      # BlockchainEvents.Repo,
      # Start the Telemetry supervisor
      BlockchainEventsWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: BlockchainEvents.PubSub},
      # Start the Endpoint (http/https)
      BlockchainEventsWeb.Endpoint,
      {Cachex, :cache_gss_data},
      GSS.DataSync
      # Start a worker by calling: BlockchainEvents.Worker.start_link(arg)
      # {BlockchainEvents.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BlockchainEvents.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    BlockchainEventsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
