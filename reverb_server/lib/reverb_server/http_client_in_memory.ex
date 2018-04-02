defmodule HTTPClient.InMemory do
  @moduledoc """
  Use to test HTTPClient. Returns mock data.
"""

  # require Logger
  # @host "https://api.reverb.com/api"

  # def do_make_request(url, opts \\ []) do
  #   # get http request opts from map and assign defaults if needed
  #   method = Keyword.get(opts, :method, :get)
  #   accept = Keyword.get(opts, :accept, "application/json")
  #   content_type = Keyword.get(opts, :content_type, "application/json")
  #   accept_version = Keyword.get(opts, :accept_version)
  #   params = Keyword.get(opts, :params, %{})
  #   body_str = Keyword.get(opts, :body_string, %{})

  #   headers = ["Content-Type": content_type,
  #     "Accept": accept,
  #     "Accept-Version": accept_version]

  #   # strips out header keys with no values
  #   headers = Enum.filter(headers, fn {k, nil} -> false; _ -> true end)

  #   case url do
  #     @host <> "/listings/all" -> Logger.info("")
  #     @host <> "/categories/flat" -> Logger.info("")
  #   end

  # end

  # defp get_json(file) do
  #   with {:ok, body} <- File.read(filename),
  #        {:ok, json} <- Poison.decode(body),
  #        do: {:ok, json}
  #        else :error
  # end


end
