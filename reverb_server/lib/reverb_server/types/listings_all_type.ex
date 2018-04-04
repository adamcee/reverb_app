defmodule ReverbServer.ListingsAllTypes do
  @moduledoc """
  Represent the entire response from /listings/all
  See mock_data/listings_all.json for sample response body
  """

  alias ReverbServer.Utils, as: U
  alias ReverbServer.ListingsAllType, as: T
  alias ReverbServer.ListingTypes, as: LT
  alias ReverbServer.LinkTypes, as: Link


  @doc """
  Struct to hold the complete response from /listings/all
  """
  # TODO: Finish
  # defmodule ListingsAll do
  #   @enforce_keys [:links, :current_page, :humanized_params, :listings,
  #     :per_page, :ships_to, :total, :total_pages]
  #   defstruct @enforce_keys

  #   @type t :: %ListingsAll{
  #     links: , 
  #     current_page:,
  #     humanized_params:,
  #     listings:,
  #     per_page:,
  #     ships_to:,
  #     total:,
  #     total_pages:
  #   }

  #   # This could be done more cleanly, but is straightforward and it works.
  #   def from_str_map(map_json) do
  #     parsed = U.str_keys_to_atoms(map_json)

  #     links = parsed[:_links]
  #     links = U.str_keys_to_atoms(links)
  #     links = Map.to_list(links)
  #             |> Enum.map(fn({key, link}) -> {key, Link.Link.from_str_map(link)} end)
  #             |> Enum.into(%{})
  #     parsed = Map.put(parsed, :_links, links)

  #     listings = parsed[:listings]
  #     listings = Enum.map(listings, &LT.Listing.from_str_map/1)
  #     parsed = Map.put(parsed, :listings, listings)
  #     struct(ListingsAll, parsed)

  #   end
  # end


end
