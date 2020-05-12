# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :blockchain_events,
  ecto_repos: [BlockchainEvents.Repo]

# Configures the endpoint
config :blockchain_events, BlockchainEventsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "xhfGlmVGNQh5YwPakdjrIpVuV0Ik/tVI70Y9lkSPEIMWDFOHuabMzGUKaR/ioWSI",
  render_errors: [view: BlockchainEventsWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: BlockchainEvents.PubSub,
  live_view: [signing_salt: "0KGeserJ"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :goth, json: "./config/blockchain_events.json" |> File.read!()

config :elixir_google_spreadsheets, :client,
  request_workers: 50,
  max_demand: 100,
  max_interval: :timer.minutes(1),
  interval: 100

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
