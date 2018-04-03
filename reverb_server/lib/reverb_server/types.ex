defmodule ReverbServer.Types do
  @moduledoc """
  Types for working with JSON returned by the Reverb API
  """

  alias ReverbServer.Types, as: T
  alias ReverbServer.Utils, as: U

  defmodule CategoriesFlatResponseBody do
    defstruct [:categories]
    @enforce_keys [:categories]
    @type t :: %CategoriesFlatResponseBody {
                 categories: list(T.Category)
               }
  end

  defmodule Category do
    @enforce_keys [:_links, :collection_title, :collection_title,
      :full_name, :listable, :name, :root_slug, :root_uuid,
      :slug, :uuid]
    defstruct [:_links, :collection_title, :collection_title,
      :full_name, :listable, :name, :root_slug, :root_uuid,
      :slug, :uuid]

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
       cat_links = CategoryLinks.from_str_map(map_json["_links"])
     end
  end

  defmodule CategoryLinks do
    @enforce_keys [:collection_header_image, :follow, :image,
      :listings, :self, :follow, :web]
    defstruct [:collection_header_image, :follow, :image,
      :listings, :self, :follow, :web]

    @type t:: %CategoryLinks {
      collection_header_image: String.t,
      follow: String.t,
      image: String.t,
      listings: String.t,
      self: String.t,
      follow: String.t,
      web: String.t,
    }

    def from_str_map(map_json) do
      # TODO: Convert map_json to keylist, then convert as below, then turn back to map.
      # Convert like {"follow": "href" => "http://google.com"}
      # to  {"follow": "http://google.com"}, etc

      map_json
      |> Map.to_list
      |> Enum.map(fn ({key, {"href", href_val}}) -> {String.to_atom(key), href_val} end)
      |> Enum.into(%{})
      |> (fn parsed_map -> struct(CategoryLinks, parsed_map) end).()
    end
  end

 end
