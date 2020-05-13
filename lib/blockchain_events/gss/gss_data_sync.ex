defmodule GSS.DataSync do
  alias GSS.Data

  def init() do
    {:ok, pid} =
      GSS.Spreadsheet.Supervisor.spreadsheet("1gwtJck9uYwNjFylctau0ZdlRGkN3_dLZepZPzWp4Hto")

    pid
  end

  def read_rows() do
    pid = init()
    {:ok, rows_number} = GSS.Spreadsheet.rows(pid)

    {:ok, headers} = GSS.Spreadsheet.read_row(pid, 1, column_to: 15, pad_empty: true)
    headers = Enum.map(headers, fn str -> String.to_atom(str) end)

    {:ok, rows} = GSS.Spreadsheet.read_rows(pid, 2, rows_number, column_to: 15, pad_empty: true)

    map =
      rows
      |> Enum.map(fn values ->
        Enum.zip(headers, values)
        |> Enum.into(%{})
        |> reformat_values()
        |> Enum.into(%{})
        |> struct_from_map(as: %Data{})
      end)
  end

  def reformat_values(values_list) do
    Enum.map(values_list, fn {k, v} ->
      case k do
        :id ->
          {k, String.to_integer(v)}

        :date ->
          {k, convert_to_date(v)}

        :technologies ->
          {k, String.split(v, ";")}

        :dev_type ->
          {k, String.split(v, ";")}

        :organizers ->
          {k, String.split(v, ";")}

        :prize ->
          {k,
           if v === "TRUE" do
             true
           else
             false
           end}

        :price ->
          {k,
           if v === "TRUE" do
             true
           else
             false
           end}

        :urls ->
          {k, String.split(v, ";")}

        _ ->
          {k, v}
      end
    end)
  end

  def convert_to_date(date_str) do
    [year, month, day] =
      date_str
      |> String.split("/")
      |> Enum.map(fn str -> String.to_integer(str) end)

    {:ok, date} = Date.new(year, month, day)
    date
  end

  def struct_from_map(a_map, as: a_struct) do
    # Find the keys within the map
    keys =
      Map.keys(a_struct)
      |> Enum.filter(fn x -> x != :__struct__ end)

    # Process map, checking for both string / atom keys
    processed_map =
      for key <- keys, into: %{} do
        value = Map.get(a_map, key) || Map.get(a_map, to_string(key))
        {key, value}
      end

    a_struct = Map.merge(a_struct, processed_map)
    a_struct
  end
end
