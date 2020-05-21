defmodule GSS.Data do
  @typedoc """
      Type that represents GSS.Data struct.
  """
  @type t :: %__MODULE__{
          id: integer,
          event_name: String.t(),
          event_type: String.t(),
          start_date: Date.t(),
          end_date: Date.t(),
          blockchain: String.t(),
          topics: list(),
          dev_type: String.t(),
          organizers: list(),
          prize: boolean(),
          price: boolean(),
          summary: String.t(),
          rounds_and_dates: String.t(),
          prizes_description: String.t(),
          prices: String.t(),
          site_url: String.t(),
          fb: String.t(),
          twitter: String.t(),
          telegram: String.t(),
          youtube: String.t(),
          image_url: String.t()
        }

  defstruct [
    :id,
    :event_name,
    :event_type,
    :start_date,
    :end_date,
    :blockchain,
    :topics,
    :dev_type,
    :organizers,
    :prize,
    :price,
    :summary,
    :rounds_and_dates,
    :prizes_description,
    :prices,
    :site_url,
    :fb,
    :twitter,
    :telegram,
    :youtube,
    :image_url
  ]
end
