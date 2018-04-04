defmodule ReverbServerWeb.APIControllerTest do
  use ReverbServerWeb.ConnCase

  test "GET /listings/all", %{conn: conn} do
    conn = get conn, "/api/listings/all"
    assert json_response(conn, 200)
  end

  test "GET /categories/flat", %{conn: conn} do
    conn = get conn, "/api/categories/flat"
    assert json_response(conn, 200)
  end
end
