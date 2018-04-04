defmodule ReverbServer.ShippingTypesTest do
  @moduledoc false

  require Logger
  alias ReverbServer.ShippingTypes, as: ST
  alias ReverbServer.Utils, as: U
  ExUnit.start()

  defmodule ShippingTest do
    use ExUnit.Case, async: true

    test "assert RateFields struct builds" do
      {listings, listing, shipping, initial_offer_rate, rate, rate_fields} = U.get_listings_all_mock_data()
      struct = ST.RateFields.from_str_map(rate_fields)
      case struct.amount do
        "24.99" -> assert true
      end
    end

  end

end