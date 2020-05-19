defmodule BlockchainEventsWeb.EventsListingLive do
  use Phoenix.LiveView
  use Timex
  require Logger

  alias BlockchainEventsWeb.EventsListingView
  alias GSS.DataSync

  def mount(_params, _session, socket) do
    ss_static_data = [
      %GSS.Data{
        blockchain: "Bitcoin",
        date: ~D[2020-05-18],
        dev_type: "experienced",
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
        blockchain: "Ethereum",
        date: ~D[2020-12-25],
        dev_type: "junior",
        event_name: "dsd",
        event_type: "seminar",
        id: 2,
        image_url: "https://cdn.pixabay.com/photo/2020/03/27/15/31/norway-4973912__340.jpg",
        organizers: ["xvxcv"],
        price: false,
        prices: "asd",
        prize: true,
        prizes_description: "xcv c",
        rounds_and_dates: "sdf vx",
        summary: nil,
        technologies: ["svcxvv"],
        urls: ["sdfsf"]
      }
    ]

    filters = %{
      event_types: [
        "All events",
        "Seminar",
        "Conference",
        "Workshop",
        "Course",
        "Competition",
        "Hackaton",
        "Other"
      ]
    }

    # DataSync.read_rows() |> IO.inspect()

    socket =
      socket
      |> assign(:ss_static_data, ss_static_data)
      |> assign(:filters, filters)
      |> assign(:ss_data, ss_static_data)
      |> assign(:applied_filters, :applied_filters)

    {:ok, socket}
  end

  def render(assigns) do
    EventsListingView.render(
      "index.html",
      assigns
    )
  end

  def handle_event("apply_filters", filters, socket) do
    ss_data =
      socket.assigns.ss_static_data
      |> date_filter(filters)
      |> event_type_filter(filters)
      |> blockchain_type_filter(filters)
      |> price_filter(filters)
      |> dev_type_filter(filters)

    {:noreply, assign(socket, :ss_data, ss_data)}
  end

  def handle_event("read more", %{"event" => event}, socket) do
    IO.inspect(event)
    {:noreply, socket}
  end

  def dev_type_filter(pf_data, filters) do
    if Map.has_key?(filters, "dev_type") == true do
      case filters["dev_type"] do
        "junior" -> Enum.filter(pf_data, fn map -> map.dev_type === "junior" end)
        "middle" -> Enum.filter(pf_data, fn map -> map.dev_type === "middle" end)
        "experienced" -> Enum.filter(pf_data, fn map -> map.dev_type === "experienced" end)
        _ -> pf_data
      end
    else
      pf_data
    end
  end

  def price_filter(bc_data, filters) do
    if Map.has_key?(filters, "price") == true do
      case filters["price"] do
        "free" -> Enum.filter(bc_data, fn map -> map.price === false end)
        "paid" -> Enum.filter(bc_data, fn map -> map.price === true end)
        _ -> bc_data
      end
    else
      bc_data
    end
  end

  def blockchain_type_filter(et_data, filters) do
    bc_data =
      Enum.filter(filters, fn {k, v} -> v === "bc_type" end)
      |> Enum.into(%{})

    if bc_data === %{} || Map.has_key?(bc_data, "all") do
      et_data
    else
      bc_types = Enum.map(bc_data, fn {k, v} -> k end)

      Enum.filter(et_data, fn map -> map.blockchain in bc_types end)
    end
  end

  def event_type_filter(df_data, filters) do
    et_data =
      Enum.filter(filters, fn {k, v} -> v === "true" end)
      |> Enum.into(%{})

    if et_data === %{} || Map.has_key?(et_data, "all") do
      df_data
    else
      event_types = Enum.map(et_data, fn {k, v} -> k end)
      Enum.filter(df_data, fn map -> map.event_type in event_types end)
    end
  end

  def date_filter(ss_data, filters) do
    if Map.has_key?(filters, "dates") == true do
      today = Timex.today()

      case filters["dates"] do
        "today" ->
          today = Timex.today()
          Enum.filter(ss_data, fn map -> map.date == today end)

        "week" ->
          beginning_of_week = Timex.beginning_of_week(today)

          week_interval =
            Timex.Interval.new(
              from: beginning_of_week,
              until: [days: 7],
              left_open: false,
              right_open: true
            )

        "month" ->
          beginning_of_month = Timex.beginning_of_month(today)
          end_of_month = Timex.end_of_month(today)

          month_interval =
            Timex.Interval.new(
              from: beginning_of_month,
              until: end_of_month,
              left_open: false,
              right_open: true
            )

          Enum.filter(ss_data, fn map -> map.date in month_interval end)

        "year" ->
          beginning_of_year = Timex.beginning_of_year(today)
          end_of_year = Timex.end_of_year(today)

          year_interval =
            Timex.Interval.new(
              from: beginning_of_year,
              until: end_of_year,
              left_open: false,
              right_open: true
            )

          Enum.filter(ss_data, fn map -> map.date in year_interval end)

        _ ->
          ss_data
      end
    else
      ss_data
    end
  end
end
