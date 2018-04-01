defmodule ReverbApp.ReverbApi do
  alias ReverbApp.HTTPRequestUtils, as: HTTP
  alias ReverbApp.HTTPEncodingUtils, as: EU
  require Logger

  def get_all_listings do
    get("/listings/all")
  end

  defp get(endpoint, opts \\ []) do
    opts = [{:method, :get} | opts]
    make_json_request(endpoint, opts)
  end

  defp make_json_request(endpoint, opts) do
    url = "https://api.reverb.com/api" <> endpoint

    opts = [{:accept, "application/hal+json"} | opts]
    opts = [{:accept_version, "3.0"} | opts]
    opts = [{:content_type, "application/hal+json"} | opts]
    opts = [{:body_string, EU.encode_body(opts)} | opts]

    case HTTP.do_make_request(url, opts) do
      {:error, :failure} ->
        Logger.error("Tried call to #{url}, failed.")
        {:error, :failure}
      {:ok, {opts, response_body}} ->
        EU.decode_body(opts, response_body)
    end
  end
end
