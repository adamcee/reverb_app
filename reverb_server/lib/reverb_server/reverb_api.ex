defmodule ReverbServer.ReverbAPI do
  @moduledoc"""
  Functions to interact with the Reverb API.
  These should exactly mirror the API itself and not do anything extra -
  handle data parsing and manipulation in a module like ReverbAPIHelpers.
  """

  alias ReverbServer.HTTPClientHelpers, as: HTTP
  alias ReverbServer.CategoryTypes, as: CT
  alias ReverbServer.ListingTypes, as: LT
  alias ReverbServer.Utils, as: U
  require Logger


  @host "https://api.reverb.com/api"

  def get_listings_all(params \\ %{}) do
    params = Map.put(params, :per_page, 10)
    case reverb_get_json("/listings/all", [{:params, params}]) do
      {:ok, json} ->
        json = U.str_keys_to_atoms(json)
        listings = Enum.map(json[:listings], &LT.Listing.from_str_map/1)
        # partially use structs - need to finish the struct for the entire response,
        # but this gets us 90% of the way there as all the listings are structs now
        # and all non-nested top-level keys are atoms, which is what we'd do in a struct anyway.
        json = Map.put(json, :listings, listings)
        {:ok, json}
      {:error, reason} -> {:error, reason}
    end
  end

  def get_categories_flat do
    case reverb_get_json("/categories/flat") do
      {:ok, json} -> {:ok, CT.CategoriesFlat.from_str_map(json)}
      {:error, reason} -> {:error, reason}
    end
  end

  defp reverb_get_json(endpoint, opts \\ []) do
    opts = [{:accept_version, "3.0"} | opts]
    HTTP.get_hal_json(@host <> endpoint, opts)
  end

end
