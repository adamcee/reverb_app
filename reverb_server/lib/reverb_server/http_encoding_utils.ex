defmodule ReverbApp.HTTPEncodingUtils do
  require Logger

  # encodes response body
  # param: content_type
  # example: "application/json"
  # param: response_body
  # the unencoded http response body string
  # return: encoded http response body string
  def encode_body(opts) do
    content_type = Keyword.get(opts, :content_type, "application/json")
    body = Keyword.get(opts, :body, %{})
    case content_type do
      "application/json" -> Poison.encode!(body)
      "application/hal+json" -> Poison.encode!(body)
      _ -> body
    end
  end

  # decodes response body
  # param: accept
  # example: "application/json"
  # param: response_body
  # the undecoded http response body string
  # return: decoded http response body string
  def decode_body(accept, response_body) do
    case accept do
      "application/json" -> {:ok, Poison.decode!(response_body)}
      "application/hal+json" -> {:ok, Poison.decode!(response_body)}
      _ -> {:ok, response_body}
    end
  end

end
