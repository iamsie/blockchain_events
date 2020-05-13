defmodule BlockchainEventsWeb.EventsListingLive do
  use Phoenix.LiveView
  require Logger

  alias BlockchainEventsWeb.EventsListingView
  alias GSS.DataSync

  def mount(_params, _session, socket) do
    ss_data = DataSync.read_rows()

    socket =
      socket
      |> assign(:ss_data, ss_data)

    {:ok, socket}
  end

  def render(assigns) do
    EventsListingView.render("index.html", assigns)
  end
end
