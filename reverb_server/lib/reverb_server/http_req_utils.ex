defmodule ReverbApp.HTTPRequestUtils do
  @moduledoc"""
  Lower-level HTTP request calling functions.
  Mostly helper wrappers around HTTPotion for builidng request headers
  and handling errors.
  """

  require Logger

  @doc """
  NOTE: The calling code is responsible for the encoding of the request body
  and the decoding of response body. This allows for custom content types
  to be nicely handled.

  param: url
  string, url to request from.
  example: 'http://reverb.com/api/categories/flat'

  param: opts
  keyword list, can contain query options such as HTTP method, params, body, headers, etc.
  example: [{:method, :get}, {:body, %{foo: 'foo_val', bar: 'bar_val'}]

  return: {:ok, {"application/json", undecoded_response_body}} | {:error, :failure}
  returns a tuple with :ok, and a tuple with the accepts type and undecoded response body.
  On error returns an error tuple.
  """
  def do_make_request(url, opts \\ []) do
    # get http request opts from map and assign defaults if needed
    method = Keyword.get(opts, :method, :get)
    accept = Keyword.get(opts, :accept, "application/json")
    content_type = Keyword.get(opts, :content_type, "application/json")
    accept_version = Keyword.get(opts, :accept_version)
    params = Keyword.get(opts, :params, %{})
    body_str = Keyword.get(opts, :body_string, %{})

    headers = ["Content-Type": content_type,
               "Accept": accept,
               "Accept-Version": accept_version]

    # strips out header keys with no values
    headers = Enum.filter(headers, fn {k, nil} -> false; _ -> true end)

    # pick appropriate http verb and associated requesting function
    {method_fn, opts} =
      case method do
        :get -> {&HTTPotion.get/2, [headers: headers, query: params, timeout: 45_000]}
        :put -> {&HTTPotion.put/2, [headers: headers, body: body_str, timeout: 45_000]}
        :post -> {&HTTPotion.post/2, [headers: headers, body: body_str, timeout: 45_000]}
        :delete -> {&HTTPotion.delete/2, [headers: headers, body: body_str, timeout: 45_000]}
      end


    # execute http request function and return {opts, response_body}, or error
    # Logger.info("Making call to #{url} with params #{inspect params}")
    case method_fn.(url, opts) do
      %HTTPotion.Response{body: response_body, status_code: code, headers: headers} when 200 <= code and code <= 299 ->
        # Logger.info("Response headers: #{inspect headers}")
        {:ok, {accept, response_body}}
      e ->
        Logger.error("Failed call to #{url}")
        Logger.error("Called with #{inspect opts}")
        Logger.error("Response headers: #{inspect headers}")
        Logger.error("Failure: #{inspect e}")
        {:error, :failure}
    end
  end
end
