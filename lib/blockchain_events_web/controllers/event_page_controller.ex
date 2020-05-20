defmodule BlockchainEventsWeb.EventPageController do
  use BlockchainEventsWeb, :controller
  alias GSS.DataSync

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def show(conn, %{"id" => id}) do
    event =
      DataSync.read_rows()
      |> Enum.filter(fn map -> map.id === String.to_integer(id) end)
      |> List.first()
      |> IO.inspect()

    render(conn, "index.html", event: event)
  end
end
