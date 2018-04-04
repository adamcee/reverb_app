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
      case ST.RateFields.from_str_map(rate_fields) do
        _correct = %ST.RateFields{} -> assert true
      end
    end

    test "assert IORateContainer struct builds" do
      {listings, listing, shipping, initial_offer_rate, rate, rate_fields} = U.get_listings_all_mock_data()
      case ST.IORateContainer.from_str_map(rate) do
        _correct = %ST.IORateContainer{} -> assert true
      end
    end

    test "assert InitialOfferRate struct builds" do
      {listings, listing, shipping, initial_offer_rate, rate, rate_fields} = U.get_listings_all_mock_data()
      case ST.InitialOfferRate.from_str_map(initial_offer_rate) do
        _correct = %ST.InitialOfferRate{} -> assert true
      end
    end

  end

end