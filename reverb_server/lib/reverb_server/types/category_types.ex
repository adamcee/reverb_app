defmodule ReverbServer.CategoryTypes do
  @moduledoc """
  Types for working with JSON returned by the Reverb API
  """

  alias ReverbServer.CategoryTypes, as: T
  alias ReverbServer.Utils, as: U

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
       parsed_map = U.str_keys_to_atoms(updated)
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


  @doc """
  Retrieve the href val and convert a nested map w/string keys
  like `{"follow": %{"href" => "http://google.com"}}`
  to a Keylist w/an atom key `{:follow, "http://google.com"}`
  """
  def flatten_href({key, %{"href" => href_val}}) when is_binary(key) do
    {String.to_atom(key), href_val}
  end

end
