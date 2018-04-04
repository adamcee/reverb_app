defmodule ReverbServer.LinkTypes do
  @moduledoc """
  Types for working with JSON returned by the Reverb API
  """

  alias ReverbServer.LinkTypes, as: T
  alias ReverbServer.Utils, as: U

  @doc """
  Use for all sorts of structs for handling response data from
  the Reverb API. Container for hal-jason/HATEOAS
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
      link_map = U.str_keys_to_atoms(map_json)
      case Map.has_key?(link_map, :method) do
        true ->
          val = Map.get(link_map, :method)
          parsed = Map.put(link_map, :method, String.to_atom(val))
          struct(T.Link, parsed)
        false -> struct(T.Link, link_map)
      end
    end

  end

end
