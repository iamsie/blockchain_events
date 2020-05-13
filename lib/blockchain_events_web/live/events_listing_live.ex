defmodule BlockchainEventsWeb.EventsListingLive do
  use Phoenix.LiveView
  require Logger

  alias BlockchainEventsWeb.EventsListingView
  alias GSS.DataSync

  def mount(_params, _session, socket) do
    ss_data = [
      %GSS.Data{
        blockchain: "jhjh",
        date: ~D[2020-12-24],
        dev_type: ["sdgdg"],
        event_name: "n",
        event_type: "course",
        id: 1,
        organizers: ["sgsgd"],
        price: true,
        prices: "afsfa",
        prize: true,
        prizes_description: "afsf",
        rounds_and_dates: "afsaf",
        summary: nil,
        technologies: ["dgdg"],
        urls: ["afsafasf"]
      },
      %GSS.Data{
        blockchain: "sdfsdf",
        date: ~D[2020-12-25],
        dev_type: ["wfxc"],
        event_name: "dsd",
        event_type: "seminar",
        id: 2,
        organizers: ["xvxcv"],
        price: nil,
        prices: "asd",
        prize: true,
        prizes_description: "xcv c",
        rounds_and_dates: "sdf vx",
        summary: nil,
        technologies: ["svcxvv"],
        urls: [""]
      }
    ]

    # DataSync.read_rows()

    socket =
      socket
      |> assign(:ss_data, ss_data)

    {:ok, socket}
  end

  def render(assigns) do
    EventsListingView.render("index.html", assigns)
  end
end
