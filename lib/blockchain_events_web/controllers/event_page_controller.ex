defmodule BlockchainEventsWeb.EventPageController do
  use BlockchainEventsWeb, :controller
  alias GSS.DataSync

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def show(conn, %{"id" => id}) do
    {:ok, data} = Cachex.get(:cache_gss_data, :gss)

    event =
      data
      |> Enum.filter(fn map -> map.id === String.to_integer(id) end)
      |> List.first()

    render(conn, "index.html", event: event)
  end
end
