defmodule ReverbServer.ListingTypesTest do
  @moduledoc false

  require Logger
  alias ReverbServer.ListingTypes, as: T
  alias ReverbServer.Utils, as: U
  ExUnit.start()

  defmodule ListingLinksTest do
    use ExUnit.Case, async: true
    test "assert ListingLinks.from_str_map creates ListingLinks struct from json" do
      # get the _links from the first List item in our mock data
      {:ok, json} = U.get_json_file("mock_data/mock_listings_all.json")
      %{"listings" => [%{"_links" => links} | _list_tail ]} = json

       case T.ListingLinks.from_str_map(links) do
         _correct = %T.ListingLinks{} -> assert true
       end

    end
  end

  # defmodule ListingsAllTest do
  #   use ExUnit.Case, async: true
  #   test "assert ListingsAll.from_str_map makes the struct from json" do
  #     {:ok, json} = U.get_json_file("mock_data/mock_listings_all.json")
  #     case T.ListingsAll.from_str_map(json) do
  #       _correct = %T.ListingsAll{} -> assert true
  #     end
  #   end
  # end

end