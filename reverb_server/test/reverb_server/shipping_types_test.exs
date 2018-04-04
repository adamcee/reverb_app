defmodule ReverbServer.ShippingTypesTest do
  @moduledoc false

  require Logger
  alias ReverbServer.ShippingTypes, as: ST
  alias ReverbServer.Utils, as: U
  ExUnit.start()

  defmodule ShippingTest do
    use ExUnit.Case, async: true

    test "assert RateFields struct builds" do
      {_listings, _listing, shipping, initial_offer_rate, rate, rate_fields} = U.get_listings_all_mock_data()
      case ST.RateFields.from_str_map(rate_fields) do
        _correct = %ST.RateFields{} -> assert true
      end
    end

    test "assert IORateContainer struct builds" do
      {_listings, _listing, shipping, initial_offer_rate, rate, rate_fields} = U.get_listings_all_mock_data()
      case ST.IORateContainer.from_str_map(rate) do
        _correct = %ST.IORateContainer{} -> assert true
      end
    end

    test "assert InitialOfferRate struct builds" do
      {_listings, _listing, shipping, initial_offer_rate, rate, rate_fields} = U.get_listings_all_mock_data()
      case ST.InitialOfferRate.from_str_map(initial_offer_rate) do
        _correct = %ST.InitialOfferRate{} -> assert true
      end
    end

    test "assert RateContainer struct builds" do
      {_listings, _listing, shipping, initial_offer_rate, rate, rate_fields} = U.get_listings_all_mock_data()
      %{"rates" => rates_list} = shipping
      [rate_container | _tail] = rates_list
      case ST.RateContainer.from_str_map(rate_container) do
        _correct = %ST.RateContainer{} -> assert true
      end
    end

    test "assert Shipping struct builds" do
      {_listings, _listing, shipping, initial_offer_rate, rate, rate_fields} = U.get_listings_all_mock_data()
      case ST.Shipping.from_str_map(shipping) do
        _correct = %ST.Shipping{} -> assert true
      end
    end
  end

end