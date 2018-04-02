defmodule ReverbApp.ReverbAPI do
  @moduledoc"""
  Functions to interact with the Reverb API.
  These should exactly mirror the API itself and not do anything extra -
  handle data parsing and manipulation in a module like ReverbAPITools.
  """

  alias ReverbApp.HTTPRequestUtils, as: HTTP
  require Logger

  @host "https://api.reverb.com/api"

  def get_listings_all(params \\ %{}) do
    HTTP.get_json(@host <> "/listings/all", [{:params, params}])
  end

  def get_categories_flat do
    HTTP.get_json(@host <> "/categories/flat")
  end

end
