defmodule ReverbApp.HttpReqUtils do
  require Logger

  # think this is for if no opts get passed somehow
  def do_make_request(_url, opts \\ [])

  @doc """
  param: url - string, url to request from.
     ex: 'http://reverb.com/api/categories/flat'
  param: opts - keyword list, can contain query options such as HTTP method, params, body, headers, etc.
     ex: [{:method, :get}, {:body, %{foo: 'foo_val', bar: 'bar_val'}]
  returns the result of an http request, along with http response code, and error if appropriate.
  """
  def do_make_request(url, opts) do
    # get http request opts from map and assign defaults if needed
    method = Keyword.get(opts, :method, :get)
    params = Keyword.get(opts, :params, %{})
    body = Keyword.get(opts, :body, %{})
    accept = Keyword.get(opts, :accept, "application/json")
    content_type = Keyword.get(opts, :content_type, "application/json")

    headers = ["Content-Type": content_type,
               "Accept": accept]

    # strips out header keys with no values
    headers = Enum.filter(headers, fn {k, nil} -> false; _ -> true end)

    body_str = case content_type do
                 "application/json" -> Poison.encode!(body)
                 _ -> body
               end

    # pick appropriate http verb and associated requesting function
    {method_fn, opts} =
      case method do
        :get -> {&HTTPotion.get/2, [headers: headers, query: params, timeout: 45_000]}
        :put -> {&HTTPotion.put/2, [headers: headers, body: body_str, timeout: 45_000]}
        :post -> {&HTTPotion.post/2, [headers: headers, body: body_str, timeout: 45_000]}
        :delete -> {&HTTPotion.delete/2, [headers: headers, body: body_str, timeout: 45_000]}
      end

    # execute http request function, parse results, and return them
    case method_fn.(url, opts) do
      %HTTPotion.Response{body: response_body, status_code: code} when 200 <= code and code <= 299 ->
        # decode response body appropriately
        case accept do
          "application/json" -> {:ok, Poison.decode!(response_body)}
          _ -> {:ok, response_body}
        end
      e ->
        Logger.error("Failed call to #{url}")
        Logger.error("Called with #{inspect opts}")
        Logger.error("Failure: #{inspect e}")
        {:error, :failure}
    end
  end

end
