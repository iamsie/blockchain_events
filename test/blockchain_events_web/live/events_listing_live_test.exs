defmodule BlockchainEventsWeb.EventsListingLiveTest do
  use BlockchainEventsWeb.ConnCase
  alias GSS.DataSync

  import Phoenix.LiveViewTest

  @data [
    %GSS.Data{
      id: 1,
      event_name: "Incredible Event",
      event_type: "course",
      start_date: ~D[2020-05-18],
      end_date: ~D[2020-05-20],
      blockchain: "Bitcoin",
      topics: ["PoS", "PoW"],
      dev_type: "experienced",
      organizers: ["Super Foundation"],
      prize: true,
      price: false,
      summary: "Event that will change your life",
      rounds_and_dates: "Start today",
      prizes_description: "The winner will go to the Moon with Elon Musk",
      prices: "N/A",
      site_url: "www.incredibleevent.com",
      fb: "www.gb.com",
      twitter: "",
      telegram: "",
      youtube: "",
      image_url: ""
    }
  ]

  test "disconnected and connected render", %{conn: conn} do
    Cachex.put(:cache_gss_data, :gss, @data)
    conn = get(conn, "/")

    assert html_response(conn, 200) =~ "Incredible Event"
  end
end
