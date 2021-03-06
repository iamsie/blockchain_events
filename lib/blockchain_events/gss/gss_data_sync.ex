defmodule GSS.DataSync do
  use GenServer
  use Timex
  alias GSS.Data

  def start_link(args \\ %{}, opts \\ []) do
    GenServer.start_link(__MODULE__, args, opts)
  end

  def init(args) do
    tick(1000, :update)

    {:ok, args}
  end

  def init_sheet_supervisor() do
    {:ok, pid} =
      GSS.Spreadsheet.Supervisor.spreadsheet("1gwtJck9uYwNjFylctau0ZdlRGkN3_dLZepZPzWp4Hto")

    pid
  end

  def handle_info({:tick, :update}, state) do
    pid = init_sheet_supervisor()

    clear_cache()
    fetch_and_cache_rows(pid)

    {:noreply, state}
  end

  def fetch_and_cache_rows(pid) do
    {:ok, rows_number} = GSS.Spreadsheet.rows(pid)

    {:ok, headers} = GSS.Spreadsheet.read_row(pid, 13, column_to: 21, pad_empty: true)
    headers = Enum.map(headers, fn str -> String.to_atom(str) end)

    {:ok, rows} = GSS.Spreadsheet.read_rows(pid, 14, rows_number, column_to: 21, pad_empty: true)

    map =
      rows
      |> Enum.map(fn values ->
        Enum.zip(headers, values)
        |> Enum.into(%{})
        |> reformat_values()
        |> Enum.into(%{})
        |> check_relevance()
        |> struct_from_map(as: %Data{})
      end)

    map = Enum.filter(map, &(&1 != nil))

    Cachex.put(:cache_gss_data, :gss, map)
  end

  def clear_cache() do
    Cachex.clear(:cache_gss_data)
  end

  def reformat_values(values_list) do
    Enum.map(values_list, fn {k, v} ->
      case k do
        :id ->
          {k, String.to_integer(v)}

        :start_date ->
          {k, convert_to_date(v)}

        :end_date ->
          {k, convert_to_date(v)}

        :topics ->
          {k, String.split(v, ";")}

        :organizers ->
          {k, String.split(v, ";")}

        :prize ->
          {k, convert_to_boolean(v)}

        :price ->
          {k, convert_to_boolean(v)}

        _ ->
          {k, v}
      end
    end)
  end

  def convert_to_boolean(str) do
    if str === "TRUE" do
      true
    else
      false
    end
  end

  def convert_to_date(date_str) do
    [year, month, day] =
      date_str
      |> String.split("/")
      |> Enum.map(fn str -> String.to_integer(str) end)

    {:ok, date} = Date.new(year, month, day)
    date
  end

  def check_relevance(event_map) do
    if Timex.before?(Timex.today(), event_map.end_date) === true, do: event_map
  end

  def struct_from_map(a_map, as: a_struct) do
    # Find the keys within the map
    if a_map !== nil do
      keys =
        Map.keys(a_struct)
        |> Enum.filter(fn x -> x != :__struct__ end)

      # Process map, checking for both string / atom keys
      processed_map =
        for key <- keys, into: %{} do
          value = Map.get(a_map, key)
          {key, value}
        end

      a_struct = Map.merge(a_struct, processed_map)
      a_struct
    end
  end

  defp tick(interval \\ 1_000, source) when is_integer(interval) do
    Process.send_after(self(), {:tick, source}, interval)
  end
end
