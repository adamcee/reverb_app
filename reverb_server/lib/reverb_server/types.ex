defmodule ReverbServer.Types do
  @moduledoc """
  Types for working with JSON returned by the Reverb API
  """

  alias ReverbServer.Types, as: T

  @doc """
  struct for the complete json response body returned by /categories/flat
  """
  defmodule CategoriesFlat do
    @enforce_keys [:categories]
    defstruct @enforce_keys
    @type t :: %CategoriesFlat{
                 categories: list(Category)
               }
    def from_str_map(map_json) do
      cats = Enum.map(map_json["categories"], &T.Category.from_str_map/1)
      struct(CategoriesFlat, %{categories: cats})
    end
  end

  defmodule Category do
    @enforce_keys [:_links, :collection_title, :collection_title,
      :full_name, :listable, :name, :root_slug, :root_uuid, :slug, :uuid]
    defstruct @enforce_keys

    @type t :: %Category{
                 _links: T.CategoryLinks,
                 collection_title: String.t(),
                 full_name: String.t(),
                 listable: boolean(),
                 name: String.t(),
                 root_slug: String.t(),
                 root_uuid: String.t(),
                 slug: String.t(),
                 uuid: String.t(),
               }

     def from_str_map(map_json) do
       cat_links = T.CategoryLinks.from_str_map(map_json["_links"])
       updated = Map.put(map_json, "_links", cat_links)
       parsed_map = T.str_keys_to_atoms(updated)
       struct(Category, parsed_map)
     end
  end

  defmodule CategoryLinks do
    @enforce_keys [:collection_header_image, :follow, :image,
      :listings, :self, :follow, :web]
    defstruct @enforce_keys

    @type t:: %CategoryLinks {
      collection_header_image: String.t,
      follow: String.t,
      image: String.t,
      listings: String.t,
      self: String.t,
      follow: String.t,
      web: String.t,
    }

    # NOTE: This is quite similar to Category.from_str_to_map,
    # which is written in a non-piping fashion and can serve as a good
    # reference to this function's behavior.
    def from_str_map(map_json) do
      map_json
      |> Map.to_list
      |> Enum.map(fn nested_href -> T.flatten_href(nested_href) end)
      |> Enum.into(%{})
      |> (fn parsed_map -> struct(CategoryLinks, parsed_map) end).()
    end

  end


  # @doc """
  # Struct to hold the complete response from /listings/all
  # """
  # defmodule ListingsAll do
  #   @enforce_keys [:_links, :current_page, :humanized_params, :listings,
  #     :per_page, :ships_to, :total, :total_pages]
  #   defstruct @enforce_keys

  #   # This could be done more cleanly, but is straightforward and it works.
  #   def from_str_map(map_json) do
  #     parsed = T.str_keys_to_atoms(map_json)

  #     links = parsed[:_links]
  #     links = T.str_keys_to_atoms(links)
  #     links = Map.to_list(links)
  #     |> Enum.map(fn({key, link}) -> {key, T.Link.from_str_map(link)} end)
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
                  cart: T.Link,
                  edit: T.Link,
                  make_offer: T.Link,
                  photo: T.Link,
                  self: T.Link,
                  watchlist: T.Link,
                  web: T.Link,
                }

    def from_str_map(map_json) do
      T.str_keys_to_atoms(map_json)
      |> Map.to_list
      |> Enum.map(fn({key, link}) -> {key, T.Link.from_str_map(link)} end)
      |> Enum.into(%{})
      |> (fn parsed_map -> struct(ListingLinks, parsed_map) end).()
    end
  end

  @doc """
  Use for all sorts of structs. Container for hal-jason/HATEOAS
  style info. Generally all data returned from the Reverb.com API
  seems to include api actions related to the item to perform
  (buy, get detail info, get picture, etc).
  Each "link" will have an href, maybe an http method, etc.
  """
  defmodule Link do
    @keys [:href, :method]
    @enforce_keys :href
    defstruct @keys

    @type t :: %Link {
      href: String.t,
      # :get, :post, :put, :delete
      method: atom()
    }

    def from_str_map(map_json) do
      link_map = T.str_keys_to_atoms(map_json)
      case Map.has_key?(link_map, :method) do
        true ->
          val = Map.get(link_map, :method)
          parsed = Map.put(link_map, :method, String.to_atom(val))
          struct(T.Link, parsed)
        false -> struct(T.Link, link_map)
      end
    end

  end

  @doc """
  str_map %{} map with all string keys
  Returns the map, values unchanged, with all keys as atoms
  """
  def str_keys_to_atoms(str_map = %{}) do
      str_map
      |> Map.to_list
      |> Enum.map(fn {k, v} ->  {String.to_atom(k), v} end)
      |> Enum.into(%{})
  end

  @doc """
  Retrieve the href val and convert a nested map w/string keys
  like `{"follow": %{"href" => "http://google.com"}}`
  to a Keylist w/an atom key `{:follow, "http://google.com"}`
  """
  def flatten_href({key, %{"href" => href_val}}) when is_binary(key) do
    {String.to_atom(key), href_val}
  end

end
