defmodule ReverbApp.HTTPEncodingUtils do
  @moduledoc"""
  Functions to encode or decode data for http requests/responses.
  This logic is separated out from HTTPRequestUtils so that it can be modified
  for various content-types without affecting HTTPEncodingUtils.
  """

  require Logger

  @doc """
  encodes response body
  param: content_type
  example: "application/json"
  param: response_body
  the unencoded http response body string
  return: encoded http response body string
  """
  def encode_req_json(opts) do
    content_type = Keyword.get(opts, :content_type, "application/json")
    body = Keyword.get(opts, :body, %{})
    case content_type do
      "application/json" -> Poison.encode!(body)
      "application/hal+json" -> Poison.encode!(body)
      _ -> body
    end
  end

  @doc """
  decodes response body
  param: accept
  example: "application/json"
  param: response_body
  the undecoded http response body string
  return: decoded http response body string (a Map)
  """
  def decode_response_json(accept, response_body) do
    case accept do
      "application/json" -> {:ok, Poison.decode!(response_body)}
      "application/hal+json" -> {:ok, Poison.decode!(response_body)}
      _ -> {:ok, response_body}
    end
  end

end
