defmodule ReverbServer.TypesTest do
  @moduledoc false

  require Logger
  alias ReverbServer.Types, as: T
  alias ReverbServer.Utils, as: U
  alias ReverbServer.TypesTest, as: S
  ExUnit.start()

  defmodule HelpersTest do
    use ExUnit.Case, async: true
    test "assert flatten_href returns an atom map containing the link value" do
      mock = {"google", %{"href" => "http://google.com"}}
      case T.flatten_href(mock) do
        {:google, "http://google.com"} -> assert true
        _ -> assert false
      end
    end
  end

  defmodule LinkTest do
    use ExUnit.Case, async: true
    test "assert Link.from_str_map creates a Link structure from json" do
      # get map of json from string, like we would from an http response
      {:ok, json} = Poison.encode(%{href: "http://google.com"})
      json = Poison.decode!(json)

      case T.Link.from_str_map(json) do
        _correct = %T.Link{} -> assert true
        _ -> assert false
      end
    end

    test "assert Link.from_str_map converts method val to atom - \"get\" to :get" do
      # get map of json from string, like we would from an http response
      {:ok, json} = Poison.encode(%{href: "http://google.com", method: "get"})
      json = Poison.decode!(json)

      case T.Link.from_str_map(json) do
       %T.Link{href: "http://google.com", method: :get} -> assert true
      end
    end
  end

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

  defmodule CategoryLinksTest do
    use ExUnit.Case, async: true
    test "assert CategoryLinks.from_str_map creates a CategoryLinks struct from json" do
      ##########
      # To make life easier if we need to debug this, this is what the map should like like,
      # once strings have been converted to atoms and hrefs flattened, right before we turn it into a struct
      # `desired_map = %{
      #   collection_header_image: "https://images.reverb.com/image/upload/s--j6lYjvqu--/a_exif,c_limit,f_auto,fl_progressive,g_south,h_1136,q_auto:eco,w_640/v1434729330/txn6smfi1ik6n6ngdldj.jpg",
      #   follow: "https://api.reverb.com/api/my/follows/categories/14d6cc96-ed7b-4521-bc21-7713c61e9dc5",
      #   image: "https://static.reverb.com/assets/products/blank_medium-dea976a03a050e5b5d67a23806ef2ce0.jpg",
      #   listings: "https://api.reverb.com/api/listings?category_uuid=14d6cc96-ed7b-4521-bc21-7713c61e9dc5",
      #   self: "https://api.reverb.com/api/categories/14d6cc96-ed7b-4521-bc21-7713c61e9dc5",
      #   web: "/marketplace/acoustic-guitars/12-string"
      # }`
      #
      # desired_map_str_keys = %{
      #   "collection_header_image" => "https://images.reverb.com/image/upload/s--j6lYjvqu--/a_exif,c_limit,f_auto,fl_progressive,g_south,h_1136,q_auto:eco,w_640/v1434729330/txn6smfi1ik6n6ngdldj.jpg",
      #   "follow" => "https://api.reverb.com/api/my/follows/categories/14d6cc96-ed7b-4521-bc21-7713c61e9dc5",
      #   "image" =>"https://static.reverb.com/assets/products/blank_medium-dea976a03a050e5b5d67a23806ef2ce0.jpg",
      #   "listings" => "https://api.reverb.com/api/listings?category_uuid=14d6cc96-ed7b-4521-bc21-7713c61e9dc5",
      #   "self" =>"https://api.reverb.com/api/categories/14d6cc96-ed7b-4521-bc21-7713c61e9dc5",
      #   "web" => "/marketplace/acoustic-guitars/12-string"
      # }

      # Get str map of json then pattern match to get `_links` from the first category in the `categories` list
      {:ok, json}= U.get_json_file("mock_data/mock_categories.json")
      %{"categories" => [%{"_links" => cat_links} | _cat_list_tail ]} = json

      case T.CategoryLinks.from_str_map(cat_links) do
        # assert from_str_map has created a CategoryLinks struct
        _correct_struct = %T.CategoryLinks{} -> assert true
        _ -> assert false
      end
    end
  end

  defmodule CategoryTest do
    use ExUnit.Case, async: true
    test "assert Category.from_str_map creates a Category struct from json" do
      # Get str map of json then pattern match to get the first category in the `categories` list
      {:ok, json}= U.get_json_file("mock_data/mock_categories.json")
      %{"categories" => [category | _cat_list_tail ]} = json

      case T.Category.from_str_map(category) do
        _correct_struct = %T.Category{} -> assert true
        _ -> assert false
      end
    end
  end

  defmodule CategoriesFlatTest do
    use ExUnit.Case, async: true
    test "assert CategoriesFlat.from_str_map creates a CategoriesFlatResponse struct from json" do
      {:ok, json} = U.get_json_file("mock_data/mock_categories.json")
      case T.CategoriesFlat.from_str_map(json) do
        _correct_struct = %T.CategoriesFlat{} -> assert true
        _ -> assert false
      end
    end
  end

end