defmodule ReverbApp.ReverbApi do
  alias ReverbApp.HttpReqUtils, as: HTTP
  require Logger

  def get(endpoint, opts \\ []) do
    opts = [{:method, :get} | opts]
    make_json_request(endpoint, opts)
  end

  def make_json_request(endpoint, opts \\ []) do
    url = "https://api.reverb.com/api" <> endpoint
    opts = [{:accept, "application/hal+json"} | opts]
    opts = [{:accept_version, "3.0"} | opts]
    opts = [{:content_type, "application/hal+json"} | opts]
    case HTTP.do_make_request(url, opts) do
      {:error, :failure} ->
        Logger.error("Tried call to #{url}, failed.")
        {:error, :failure}
      {:ok, results} ->
        {:ok, results}
    end
  end

end
