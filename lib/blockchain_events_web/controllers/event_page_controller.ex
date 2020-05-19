defmodule BlockchainEventsWeb.EventPageController do
  use BlockchainEventsWeb, :controller
  alias GSS.DataSync

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def show(conn, %{"id" => id}) do
    # event = DataSync.read_rows() |> Enum.filter(fn map -> map.id === id end)
    event =
      [
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
      |> Enum.filter(fn map -> map.id === String.to_integer(id) end)
      |> List.first()

    render(conn, "index.html", event: event)
  end
end
