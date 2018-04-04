defmodule ReverbServerWeb.APIController do
  use ReverbServerWeb, :controller
  alias ReverbServer.ReverbAPIHelpers, as: RAH
  alias ReverbServer.ReverbAPI, as: RA
  alias ReverbServerWeb.APIUtils, as: AU

  def listings_all(conn, params) do
    case RA.get_listings_all(params) do
      {:ok, res} -> AU.send_success(conn, res)
      _ -> AU.send_error(conn, 404)
    end
  end

  def categories_flat(conn, params) do
    # default empty string will return all categories
    str_query = Map.get(params, "q", "")
    case RAH.get_categories_with_string(str_query) do
      {:ok, res} -> AU.send_success(conn, res)
      _ -> AU.send_error(conn, 404)
    end
  end
end
