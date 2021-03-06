defmodule ReverbServerWeb.Router do
  use ReverbServerWeb, :router
  alias ReverbServer.ReverbAPI, as: ReverbAPI

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ReverbServerWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", ReverbServerWeb do
    pipe_through :api
    get "/categories/flat", APIController, :categories_flat
    get "/listings/all", APIController, :listings_all
  end
end
