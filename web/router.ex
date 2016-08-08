defmodule ClassList.Router do
  use ClassList.Web, :router

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

  scope "/", ClassList do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/admin", ClassList do
    pipe_through :browser

    resources "/buses", BusController
  end

  # Other scopes may use custom stacks.
  # scope "/api", ClassList do
  #   pipe_through :api
  # end
end
