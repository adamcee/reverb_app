defmodule ReverbServer.HTTPClientHelpers do
  @moduledoc"""
  Helper functions to interact with HTTPClient and encode/decode req/response data.
  These should be used in a separate module to compose the API-calling public functions.
  Use in conjunction with HTTPEncodingUtils (which should be kept separate).

  Mainly the lower-level functions should be kept private
  and used to compose public functions for building an API module.
  """

  require Logger
  alias ReverbServer.HTTPEncodingUtils, as: EU
  @http_client Application.get_env(:reverb_server, :http_client)

  def get_hal_json(endpoint, opts \\ []) do
    # Note: Adding an item to the head of a List in this way
    # is a constant-time operation, and thus preferable to List concatenation.
    opts = [{:method, :get} | opts]
    make_hal_json_request(endpoint, opts)
  end

  def post_hal_json(endpoint, opts \\ []) do
    opts = [{:method, :post} | opts]
    opts = [{:body_string, EU.encode_req_json(opts)} | opts]
    make_hal_json_request(endpoint, opts)
  end

  defp make_hal_json_request(url, opts) do
    opts = [{:accept, "application/hal+json"} | opts]
    opts = [{:content_type, "application/hal+json"} | opts]

    # http_client = Application.get_env(:reverb_server, :http_client)

    case @http_client.do_make_request(url, opts) do
      {:error, :failure} ->
        Logger.error("Tried call to #{url}, failed.")
        {:error, :failure}
      {:ok, {opts, json}} -> EU.decode_response_json(opts, json)
    end
  end

end
