defmodule BlockchainEvents.Repo do
  use Ecto.Repo,
    otp_app: :blockchain_events,
    adapter: Ecto.Adapters.Postgres
end
