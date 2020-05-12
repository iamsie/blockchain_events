defmodule BlockchainEventsWeb.EventsListingLive do
  use Phoenix.LiveView
  require Logger

  alias BlockchainEventsWeb.EventsListingView

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    EventsListingView.render("index.html", assigns)
  end
end
