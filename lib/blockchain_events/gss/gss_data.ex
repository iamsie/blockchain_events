defmodule GSS.Data do
  @typedoc """
      Type that represents GSS.Data struct.
  """
  @type t :: %__MODULE__{
          id: integer,
          event_name: String.t(),
          event_type: String.t(),
          date: Date.t(),
          blockchain: String.t(),
          technologies: list(),
          dev_type: list(),
          organizers: list(),
          prize: boolean(),
          price: boolean(),
          summary: String.t(),
          rounds_and_dates: String.t(),
          prizes_description: String.t(),
          prices: String.t(),
          urls: list(),
          image_url: String.t()
        }

  defstruct [
    :id,
    :event_name,
    :event_type,
    :date,
    :blockchain,
    :technologies,
    :dev_type,
    :organizers,
    :prize,
    :price,
    :summary,
    :rounds_and_dates,
    :prizes_description,
    :prices,
    :urls,
    :image_url
  ]
end
