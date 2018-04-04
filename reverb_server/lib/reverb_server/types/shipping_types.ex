defmodule ReverbServer.CategoryTypes do
  @moduledoc """
  Types for working with JSON returned by the Reverb API
  """

  alias ReverbServer.Utils, as: U

  defmodule Shipping do
    @enforce_keys[:free_expedited_shipping]
    defstruct @enforce_keys
    @type t :: %Shipping{
      free_expedited_shipping: boolean
    }

    def from_str_map(map_json) do
      parsed = U.str_keys_to_atoms(map_json)
      struct(Shipping, parsed)
    end
  end

  defmodule InitialOfferRate do
    @enforce_keys [:rate, :region_code]
    defstruct @enforce_keys
    type t :: %InitialOfferRate{
      rate: T.Rate,
      region_code: String.t
    }

    def from_str_map(map_json) do
      parsed = U.str_keys_to_atoms(map_json)
      parsed = Map.put(parsed, :rate, T.Rate.from_str_map(parsed[:rate]))
      struct(InitialOfferRate, parsed)
    end
  end

  defmodule Rate do
    @enforce_keys [:display, :original]
    defstruct @enforce_keys
    type t :: %Rate{
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
    type t :: %RateFields{
      amount: String.t,
      amount_cents: integer,
      currency: String.t,
      display: String.t,
      symbol String.t
    }

    def from_str_map(map_json) do
      parsed = U.str_keys_to_atoms(map_json)
      struct(RateFields, %{
        amount: parsed[:amount]
        amount_cents: parsed[:amount_cents],
        currency: parsed[:currency],
        display: parsed[:display],
        symbol parsed[:symbol]
      })
    end
  end



  "initial_offer_rate": {
    "rate": {
      "display": {
        "amount": "24.99",
        "amount_cents": 2499,
        "currency": "USD",
        "display": "$24.99",
        "symbol": "$"
      },
      "original": {
        "amount": "24.99",
        "amount_cents": 2499,
        "currency": "USD",
        "display": "$24.99",
        "symbol": "$"
      }
    },
    "region_code": "XX"
  },
                                "local": false,
                                "rates": [
                                      {
                                      "rate": {
                                              "amount": "24.99",
                                "amount_cents": 2499,
                                "currency": "USD",
                                         "display": "$24.99",
                                                  "symbol": "$"
                                                            },
                                                            "region_code": "JP"
                                                                         },
                                                                         {
                                                                         "rate": {
                                                                         "amount": "24.99",
                                                                                   "amount_cents": 2499,
                                                                         "currency": "USD",
                                                                         "display": "$24.99",
                                                                         "symbol": "$"
                                                                         },
                                                                         "region_code": "US"
                                                                         },
                                                                         {
                                                                         "rate": {
                                                                         "amount": "24.99",
                                                                         "amount_cents": 2499,
                                                                          "currency": "USD",
                                                                                      "display": "$24.99",
                                                                                                  "symbol": "$"
                                                                                                              },
                                                                                                              "region_code": "XX"
                                                                                                                              }
                                                                                                                              ]
                                                                                                                              },

end
