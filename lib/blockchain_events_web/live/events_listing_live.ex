defmodule BlockchainEventsWeb.EventsListingLive do
  use Phoenix.LiveView
  use Timex
  require Logger

  alias BlockchainEventsWeb.EventsListingView
  alias GSS.DataSync

  def mount(_params, _session, socket) do
    ss_static_data = [
      %GSS.Data{
        blockchain: "jhjh",
        date: ~D[2020-05-18],
        dev_type: ["sdgdg"],
        event_name: "n",
        event_type: "course",
        id: 1,
        image_url: "https://cdn.pixabay.com/photo/2020/05/11/13/49/sea-5158394__340.jpg",
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
        image_url: "https://cdn.pixabay.com/photo/2020/03/27/15/31/norway-4973912__340.jpg",
        organizers: ["xvxcv"],
        price: nil,
        prices: "asd",
        prize: true,
        prizes_description: "xcv c",
        rounds_and_dates: "sdf vx",
        summary: nil,
        technologies: ["svcxvv"],
        urls: ["sdfsf"]
      }
    ]

    date_filters = %{
      all_dates: "All dates",
      today: "Start today",
      week: "Start this week",
      month: "Start this month",
      year: "Start this year"
    }

    # DataSync.read_rows() |> IO.inspect()

    socket =
      socket
      |> assign(:ss_static_data, ss_static_data)
      |> assign(:date_filters, date_filters)
      |> assign(:ss_data, ss_static_data)

    {:ok, socket}
  end

  def render(assigns) do
    EventsListingView.render(
      "index.html",
      assigns
    )
  end

  def handle_event("date_filters", %{"All dates" => "true"} = all_dates, socket) do
    ss_data = socket.assigns.ss_static_data

    socket =
      socket
      |> assign(:ss_data, ss_data)

    {:noreply, socket}
  end

  def handle_event("date_filters", %{"Start today" => "true"}, socket) do
    ss_data = socket.assigns.ss_static_data
    today = Timex.today()

    ss_data = Enum.filter(ss_data, fn map -> map.date == today end)

    socket =
      socket
      |> assign(:ss_data, ss_data)

    {:noreply, socket}
  end

  def handle_event("date_filters", %{"Start this month" => "true"}, socket) do
    ss_data = socket.assigns.ss_static_data
    today = Timex.today()
    beginning_of_month = Timex.beginning_of_month(today)
    end_of_month = Timex.end_of_month(today)

    month_interval =
      Timex.Interval.new(
        from: beginning_of_month,
        until: end_of_month,
        left_open: false,
        right_open: true
      )

    ss_data = Enum.filter(ss_data, fn map -> map.date in month_interval end)

    socket =
      socket
      |> assign(:ss_data, ss_data)

    {:noreply, socket}
  end

  def handle_event("date_filters", %{"Start this week" => "true"}, socket) do
    ss_data = socket.assigns.ss_static_data
    today = Timex.today()
    beginning_of_week = Timex.beginning_of_week(today)

    week_interval =
      Timex.Interval.new(
        from: beginning_of_week,
        until: [days: 7],
        left_open: false,
        right_open: true
      )

    ss_data = Enum.filter(ss_data, fn map -> map.date in week_interval end)

    socket =
      socket
      |> assign(:ss_data, ss_data)

    {:noreply, socket}
  end

  def handle_event("date_filters", %{"Start this year" => "true"}, socket) do
    ss_data = socket.assigns.ss_static_data
    today = Timex.today()
    beginning_of_year = Timex.beginning_of_year(today)
    end_of_year = Timex.end_of_year(today)

    year_interval =
      Timex.Interval.new(
        from: beginning_of_year,
        until: end_of_year,
        left_open: false,
        right_open: true
      )

    ss_data = Enum.filter(ss_data, fn map -> map.date in year_interval end)

    socket =
      socket
      |> assign(:ss_data, ss_data)

    {:noreply, socket}
  end
end
