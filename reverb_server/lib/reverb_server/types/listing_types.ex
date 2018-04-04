defmodule ReverbServer.ListingTypes do
  @moduledoc """
  Types for working with JSON returned by the Reverb API
  """

  alias ReverbServer.Utils, as: U
  alias ReverbServer.ListingTypes, as: T
  alias ReverbServer.LinkTypes, as: LT
  alias ReverbServer.ShippingTypes, as: ST

  defmodule Listing do
    @enforce_keys [:_links, :auction, :categories, :condition, :created_at, :description, :finish, :has_inventory,
      :id, :inventory, :listing_currency, :make, :mode, :offers_enabled, :photos, :price, :published_at,
      :shipping, :shop, :shop_id, :shop_name, :state, :title, :year, :has_inventory, :id]

    defstruct @enforce_keys

    @struct_fields [{:_links, T.ListingLinks}, {:categories, T.ListingCategory}, {:condition, T.Condition},
      {:photos, T.PhotoLinksContainer}, {:price, T.Price}, {:shop, T.Shop}, {:state, T.State}]

    @list_fields [:photos, :categories]

    @type t :: %Listing{
      _links: T.ListingLinks,
      auction: boolean,
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
      photos: list(T.PhotoLinksContainer),
      price: T.Price,
      published_at: String.t,
      shipping: ST.Shipping,
      shop: T.Shop,
      shop_id: integer,
      shop_name: String.t,
      state:  T.State,
      title: String.t,
      year: String.t
    }

    def from_str_map(%{} = map_json) do
      parsed = U.str_keys_to_atoms(map_json)
      parsed = T.build_struct_update_map_with_self(parsed, :_links, T.ListingLinks)

      categories = Enum.map(parsed[:categories], &T.ListingCategory.from_str_map/1)
      parsed = Map.put(parsed, :categories, categories)

      parsed = T.build_struct_update_map_with_self(parsed, :condition, T.Condition)

      photo_links_containers = Enum.map(parsed[:photos], &T.PhotoLinksContainer.from_str_map/1)
      parsed = Map.put(parsed, :photos, photo_links_containers)

      parsed = T.build_struct_update_map_with_self(parsed, :price, T.Price)
      parsed = T.build_struct_update_map_with_self(parsed, :shipping, ST.Shipping)
      parsed = T.build_struct_update_map_with_self(parsed, :shop, T.Shop)
      parsed = T.build_struct_update_map_with_self(parsed, :state, T.State)

      struct(T.Listing, parsed)
    end

    # Something very clever that has bugs
    # def from_str_map(%{} = map_json) do
    #   # parsed = U.str_keys_to_atoms(map_json)
    #   map_json
    #   parsed = Map.to_list(map_json)
    #   |> Enum.map(fn({key, val}) -> {String.to_atom(key), val} end)
    #   |> Enum.map(fn ({key, val}) ->
    #       # if field is some struct convert its value to said struct.
    #       # if field is list of some struct convert list els to said struct.
    #       # otherwise return the unchanged {key, val} tuple.
    #       case get_type_if_is_struct_field(key) do
    #         {same_key, struct_type} ->
    #           case is_list_field(key) do
    #             false -> {key, struct(struct_type, val)}
    #             true -> {:key, list_items_to_structs(val, struct_type)}
    #           end
    #         _ -> {key, val}
    #       end
    #   end)
    #   |> Enum.into(%{})

    #   # struct(Listing, parsed)
    # end

      ## HELPER FUNCTIONS FOR Listing.from_str_map ##
    # check if field/key of our struct contains a struct
    # return {:my_key, my_struct_type} | nil
      defp get_type_if_is_struct_field(a_key) do
        # We can assume @struct_fields is unique.
        Enum.filter(@struct_fields, fn({b_key, type}) -> a_key == b_key end)
       |> Enum.at(0)
      end

    # check if field/key of our struct is a list
    # return boolean
     defp is_list_field(a_key) do
       # We can assume @list_fields is unique list.
       list_field = Enum.filter(@list_fields, fn b_key -> a_key == b_key end)
        case Enum.count(list_field) do
          1 -> true
          0 -> false
        end
     end

    # convert all the items in a list to a given struct.
    # can assume each item in the list is the right kind of map.
     defp list_items_to_structs(list, struct_type) do
       Enum.map(list, fn (%{} = i) -> struct(struct_type, i) end)
     end
  end



  defmodule PhotoLinksContainer do
    @enforce_keys [:_links]
    defstruct @enforce_keys
    @type t :: %PhotoLinksContainer{
                 _links: T.PhotLinks

               }

    def from_str_map(map_json) do
      parsed = U.str_keys_to_atoms(map_json)
      struct(PhotoLinksContainer, %{
        _links: T.PhotoLinks.from_str_map(parsed[:_links]),
      })
    end
  end

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
    @type t :: %Price {
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

  defmodule Condition do
    @enforce_keys [:display_name, :slug, :uuid]
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

  defmodule Shop do
    @enforce_keys [:preferred_seller, :slug]
    defstruct @enforce_keys

    @type t ::  %Shop{
      preferred_seller: boolean,
      slug: String.t
    }

    def from_str_map(map_json) do
      U.str_keys_to_atoms(map_json)
      |> (fn parsed_map -> struct(T.Shop, parsed_map) end).()
    end
  end

  defmodule State do
    @enforce_keys [:description, :slug]
    defstruct @enforce_keys

    @type t ::  %State{
      description: String.t,
      slug: String.t
    }

    def from_str_map(map_json) do
      U.str_keys_to_atoms(map_json)
      |> (fn parsed_map -> struct(T.State, parsed_map) end).()
    end
  end

  @doc """
  Accept an atom-keyed map. For a given key,
  convert the value of that key to a given struct.
  Return the updated map.
  """
  def build_struct_update_map_with_self(%{} = atom_key_map, key, struct_type) when is_atom(key) do
    val = atom_key_map[key]
    val_as_struct = struct(struct_type, val)
    Map.put(atom_key_map, key, val_as_struct)
  end

end
