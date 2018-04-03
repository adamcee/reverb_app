defmodule ReverbServer.Types do
  @moduledoc """
  Types for working with JSON returned by the Reverb API
  """

  alias ReverbServer.Types, as: T

  defmodule CategoriesFlatResponseBody do
    @enforce_keys [:categories]
    defstruct @enforce_keys
    @type t :: %CategoriesFlatResponseBody {
                 categories: list(Category)
               }
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
  def flatten_href({key, %{"href" => href_val}}) do
    {String.to_atom(key), href_val}
  end

  #@doc """
  #Convert a map with string keys to a struct
  #from: https://groups.google.com/forum/#!msg/elixir-lang-talk/6geXOLUeIpI/L9einu4EEAAJ

  # kind: The struct to create
  # attr: A map with string keys

  # Returns a struct of type kind
  # NOTE: I believe the struct must have default values for all enforced_keys for this to work.
  # NOTE: This can handle attr maps with more keys than the struct contains
  # NOTE: This will not do any conversion on nested maps - nested vals will be passed as-is!!!
  #"""
  #def to_struct(kind, attrs) do
  #  struct = struct(kind)
  #  Enum.reduce Map.to_list(struct), struct, fn {k, _}, acc ->
  #    case Map.fetch(attrs, Atom.to_string(k)) do
  #      {:ok, v} -> %{acc | k => v}
  #      :error -> acc
  #    end
  end
