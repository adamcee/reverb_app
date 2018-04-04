defmodule ReverbServer.ListingTypes do
  @moduledoc """
  Types for working with JSON returned by the Reverb API
  """

  alias ReverbServer.ListingTypes, as: T
  alias ReverbServer.LinkTypes, as: LT
  alias ReverbServer.Utils, as: U


  # @doc """
  # Struct to hold the complete response from /listings/all
  # """
  # defmodule ListingsAll do
  #   @enforce_keys [:_links, :current_page, :humanized_params, :listings,
  #     :per_page, :ships_to, :total, :total_pages]
  #   defstruct @enforce_keys

  #   # This could be done more cleanly, but is straightforward and it works.
  #   def from_str_map(map_json) do
  #     parsed = U.str_keys_to_atoms(map_json)

  #     links = parsed[:_links]
  #     links = U.str_keys_to_atoms(links)
  #     links = Map.to_list(links)
  #     |> Enum.map(fn({key, link}) -> {key, LT.Link.from_str_map(link)} end)
  #     |> Enum.into(%{})
  #     parsed = Map.put(parsed, :_links, links)

  #     listings = parsed[:listings]
  #     listings = Enum.map(listings, &T.Listing.from_str_map/1)
  #     parsed = Map.put(parsed, :listings, listings)
  #    struct(ListingsAll, parsed)

  #  end
  # end

  # defmodule Listing do
  # end

  defmodule ListingLinks do
    @enforce_keys [:cart, :edit, :make_offer, :photo, :self, :watchlist,
      :web]
    defstruct @enforce_keys

    @type t ::  %ListingLinks{
                  cart: LT.Link,
                  edit: LT.Link,
                  make_offer: LT.Link,
                  photo: LT.Link,
                  self: LT.Link,
                  watchlist: LT.Link,
                  web: LT.Link,
                }

    def from_str_map(map_json) do
      U.str_keys_to_atoms(map_json)
      |> Map.to_list
      |> Enum.map(fn({key, link}) -> {key, LT.Link.from_str_map(link)} end)
      |> Enum.into(%{})
      |> (fn parsed_map -> struct(ListingLinks, parsed_map) end).()
    end
  end

end
