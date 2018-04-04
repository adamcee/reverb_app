defmodule ReverbServer.ShippingTypes do
  @moduledoc """
  Types for the shipping_types part of a Listing Type.
  Some of the Rate-related Types may also be used elsewhere.
  see mock_data/mock_listings.json for an example of the data
  these structs are meant to represent.
  """

  alias ReverbServer.Utils, as: U
  alias ReverbServer.ShippingTypes, as: T


  defmodule Shipping do
    @enforce_keys [:free_expedited_shipping, :initial_offer_rate, :local, :rates]
    defstruct @enforce_keys
    @type t :: %Shipping{
      free_expedited_shipping: boolean,
      initial_offer_rate: T.InitialOfferRate,
      local: boolean,
      rates: list(T.RateContainer),
    }

    def from_str_map(map_json) do
      parsed = U.str_keys_to_atoms(map_json)
      struct(Shipping, parsed)
    end
  end

  defmodule RateContainer do
    @enforce_keys [:rate, :region_code]
    defstruct @enforce_keys
    @type t :: %RateContainer{
      rate: T.RateFields,
      region_code: String.t
    }

    def from_str_map(map_json) do
      parsed = U.str_keys_to_atoms(map_json)
      parsed = Map.put(parsed, :rate, T.RateFields.from_str_map(parsed[:rate]))
      struct(RateContainer, parsed)
    end
  end

  defmodule InitialOfferRate do
    @enforce_keys [:rate, :region_code]
    defstruct @enforce_keys
    @type t :: %InitialOfferRate{
      rate: T.IORate,
      region_code: String.t
    }

    def from_str_map(map_json) do
      parsed = U.str_keys_to_atoms(map_json)
      parsed = Map.put(parsed, :rate, T.IORate.from_str_map(parsed[:rate]))
      struct(InitialOfferRate, parsed)
    end
  end

  defmodule IORate do
    @enforce_keys [:display, :original]
    defstruct @enforce_keys
    @type t :: %IORate{
      display: T.RateFields,
      original: T.RateFields
    }

    def from_str_map(map_json) do
      parsed = U.str_keys_to_atoms(map_json)
      parsed = Map.put(parsed, :display, T.RateFields.from_str_map(parsed[:display]))
      parsed = Map.put(parsed, :original, T.RateFields.from_str_map(parsed[:original]))
      struct(InitialOfferRate, parsed)
    end
  end

  defmodule RateFields do
    @enforce_keys [:amount, :amount_cents, :currency, :display, :symbol]
    defstruct @enforce_keys
    # @type t:: %RateFields{
    #   amount: String.t,
    #   amount_cents: integer,
    #   currency: String.t,
    #   display: String.t,
    #   symbol String.t
    # }

    def from_str_map(map_json) do
      parsed = U.str_keys_to_atoms(map_json)
      struct(RateFields, %{
        amount: parsed[:amount],
        amount_cents: parsed[:amount_cents],
        currency: parsed[:currency],
        display: parsed[:display],
        symbol: parsed[:symbol]
      })
    end
  end

end
