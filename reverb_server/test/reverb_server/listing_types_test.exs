defmodule ReverbServer.ListingTypesTest do
  @moduledoc false

  require Logger
  alias ReverbServer.ListingTypes, as: T
  alias ReverbServer.Utils, as: U
  ExUnit.start()

  defmodule AllListingTypesTests do
    use ExUnit.Case, async: true
    test "assert ListingLinks.from_str_map creates ListingLinks struct from json" do
      # get the _links from the first List item in our mock data
      {:ok, json} = U.get_json_file("mock_data/mock_listings_all.json")
      %{"listings" => [%{"_links" => links} | _list_tail ]} = json

      case T.ListingLinks.from_str_map(links) do
        _correct = %T.ListingLinks{} -> assert true
      end
    end

    test "assert State struct builds from json" do
     {_listings, listing, _shipping, _initial_offer_rate, _rate, _rate_fields} = U.get_listings_all_mock_data()
     %{"state" => state} = listing
       case T.State.from_str_map(state) do
         _correct = %T.State{} -> assert true
       end
    end

     test "assert Shop struct builds from json" do
       {_listings, listing, _shipping, _initial_offer_rate, _rate, _rate_fields} = U.get_listings_all_mock_data()
       %{"shop" => shop} = listing
       case T.Shop.from_str_map(shop) do
         _correct = %T.Shop{} -> assert true
       end
    end

    test "assert ListingCategory struct builds from json" do
      {_listings, listing, _shipping, _initial_offer_rate, _rate, _rate_fields} = U.get_listings_all_mock_data()
      %{"categories" => categories} = listing
      [category | _tail] = categories
      case T.ListingCategory.from_str_map(category) do
        _correct = %T.ListingCategory{} -> assert true
      end
    end

    test "assert Condition struct builds from json" do
      {_listings, listing, _shipping, _initial_offer_rate, _rate, _rate_fields} = U.get_listings_all_mock_data()
      %{"condition" => condition} = listing
      case T.Condition.from_str_map(condition) do
        _correct = %T.Condition{} -> assert true
      end
    end

    test "assert Price struct builds from json" do
      {_listings, listing, _shipping, _initial_offer_rate, _rate, _rate_fields} = U.get_listings_all_mock_data()
      %{"price" => price} = listing
      case T.Price.from_str_map(price) do
        _correct = %T.Price{} -> assert true
      end
    end

    test "assert PhotoLinks struct builds from json" do
      {_listings, listing, _shipping, _initial_offer_rate, _rate, _rate_fields} = U.get_listings_all_mock_data()
      %{"photos" => [photo_links_container | _tail]} = listing
      photo_links = photo_links_container["_links"]
      case T.PhotoLinks.from_str_map(photo_links) do
        _correct = %T.PhotoLinks{} -> assert true
      end
    end

    test "assert PhotoLinksContainer struct builds from json" do
      {_listings, listing, _shipping, _initial_offer_rate, _rate, _rate_fields} = U.get_listings_all_mock_data()
      %{"photos" => [photo_links_container | _tail]} = listing
      case T.PhotoLinksContainer.from_str_map(photo_links_container) do
        _correct = %T.PhotoLinksContainer{} -> assert true
      end
    end

    test "assert Listing struct builds from json" do
      {_listings, listing, _shipping, _initial_offer_rate, _rate, _rate_fields} = U.get_listings_all_mock_data()
      case T.Listing.from_str_map(listing) do
        _correct = %T.Listing{} -> assert true
      end
    end

    # TODO: Finish the type
    # test "assert ListingsAll struct builds from json" do
    #   {listings, _listing, _shipping, _initial_offer_rate, _rate, _rate_fields} = U.get_listings_all_mock_data()
    #   case T.ListingsAll.from_str_map(listings) do
    #     _correct = %T.ListingsAll{} -> assert true
    #   end
    # end

  end

end
