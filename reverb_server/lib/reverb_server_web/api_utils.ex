defmodule ReverbServerWeb.APIUtils do
  @moduledoc """
  Helpers for the client API
  """
  @doc """
  Returns a successful JSON response.
  """
  def send_success(conn, data \\ %{}) do
    Phoenix.Controller.json(conn, data)
  end

  @doc """
  Return a JSON error response containing a HTTP status code, optional message,
  and optional response body.
  """
  def send_error(%{resp_headers: resp_headers} = conn, http_status_code, message \\ nil, resp_body \\nil) do
    data =
      if message do
        %{message: message}
      else
        %{}
      end

    data =
      if resp_body do
        Map.merge(data, resp_body)
      else
        data
      end

    %{conn | resp_headers: [{"content-type", "application/json; charset=utf-8"} | resp_headers]}
    |> Plug.Conn.send_resp(http_status_code, Poison.encode!(data))
  end

end
