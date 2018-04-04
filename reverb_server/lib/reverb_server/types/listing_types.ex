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

  defmodule PhotoLinks do
    @enforce_keys [:full, :thumbnail, :large_crop, :small_crop]
    defstruct @enforce_keys
    @type t :: %PhotoLinks{
                 full: LT.Link,
                 thumbnail: LT.Link,
                 large_crop: LT.Link,
                 small_crop: LT.Link

               }

    def from_str_map(map_json) do
      parsed = U.str_keys_to_atoms(map_json)
      struct(PhotoLinks, %{
        full: LT.Link.from_str_map(parsed[:full]),
        thumbnail: LT.Link.from_str_map(parsed[:thumbnail]),
        large_crop: LT.Link.from_str_map(parsed[:large_crop]),
        small_crop: LT.Link.from_str_map(parsed[:small_crop]),
      })
    end
  end

  defmodule Price do
    @enforce_keys [:amount, :amount_cents, :currency, :display,
                         :symbol, :tax_included]
    defstruct @enforce_keys
    type t :: %Price {
                amount: String.t,
                amount_cents: integer,
                currency: String.t,
                display: String.t,
                symbol: String.t,
                tax_included: boolean

              }

    def from_str_map(map_json) do
      parsed = U.str_keys_to_atoms(map_json)
      struct(Price, parsed)
    end

    end
  end
  defmodule Listing do
    @enforce_keys [:_links, :auction, :created_at, :description, :finish
    :has_inventory]
    defstruct @enforce_keys
    defstruct @enforce_keys
    @type t :: %Listing{
                 _links: T.ListingLinks,
                 aution: boolean,
                 categories: list(T.ListingCategory),
                 condition: T.Condition,
                 created_at: String.t,
                 description: String.t,
                 finish: String.t,
                 has_inventory: boolean,
                                id: integer,
                                inventory: integer,
                                           listing_currency: String.t,
                   make: String.t,
                   mode: String.t,
                               offers_enabled: boolean,
                               photos: list(T.PhotoLinks),
                               price: T.Price,
                               published_at: String.t,
                     "shop": {
                     "preferred_seller": false,
                                       "slug": "japanvintagefx"
                                                              },
                                                              "shop_id": 346799,
                     "shop_name": "JapanVintageFX",
                     "state": {
                     "description": "Live",
                                  "slug": "live"
                                          },
                                          "title": "Fuchs Plush Jersey Thunder (EQ/Boost/Tone Shaper) 2010s Purple",
                                                 "year": "2010s"
                                                         },


               }
  end

  defmodule Condition do
    @enforce_keys [:display_name, slug, :uuid]
    defstruct @enforce_keys
    @type t :: %Condition{
                 display_name: String.t,
                 slug: String.t,
                 uuid: String.t
               }

    def from_str_map(map_json) do
      struct(Condition, %{
        display_name: map_json["display_name"],
        slug: map_json["slug"],
        uuid: map_json["uuid"] })
    end
  end

  defmodule ListingCategory do
    @enforce_keys [:full_name, :uuid]
    defstruct @enforce_keys
    @type t :: %ListingCategory{
                 full_name: String.t,
                 uuid: String.t
               }

    def from_str_map(map_json) do
      struct(ListingCategory, %{
        full_name: map_json["full_name"],
        uuid: map_json["uuid"] })
    end
  end

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
