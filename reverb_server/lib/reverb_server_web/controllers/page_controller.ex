defmodule ReverbServerWeb.PageController do
  use ReverbServerWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
