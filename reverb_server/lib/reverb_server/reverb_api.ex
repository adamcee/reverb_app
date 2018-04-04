defmodule ReverbServer.ReverbAPI do
  @moduledoc"""
  Functions to interact with the Reverb API.
  These should exactly mirror the API itself and not do anything extra -
  handle data parsing and manipulation in a module like ReverbAPIHelpers.
  """

  alias ReverbServer.HTTPClientHelpers, as: HTTP
  alias ReverbServer.CategoryTypes, as: CT
  require Logger


  @host "https://api.reverb.com/api"

  def get_listings_all(params \\ %{}) do
    reverb_get_json("/listings/all", [{:params, params}])
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
