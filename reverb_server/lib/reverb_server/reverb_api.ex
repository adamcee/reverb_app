defmodule ReverbApp.ReverbApi do
  alias ReverbApp.HttpReqUtils, as: HTTP
  require Logger

  def get_categories(opts \\ []) do
    make_request("/categories/flat", opts)
  end

  def get_listings_all(opts \\ []) do
    make_request("/listings/all", opts)
  end

  defp make_request(endpoint, opts \\ []) do
    url = "https://api.reverb.com/api" <> endpoint
    case HTTP.do_make_request(url, opts) do
      {:error, :failure} ->
        Logger.error("Tried call to #{url}, failed.")
        {:error, :failure}
      {:ok, results} ->
        {:ok, results}
    end
  end

end
