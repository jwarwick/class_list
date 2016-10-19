defmodule ClassList.Router do
  use ClassList.Web, :router
  use Coherence.Router

  pipeline :protected do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session, login: true
  end

  pipeline :public do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session
  end

  # pipeline :api do
  #   plug :accepts, ["json"]
  # end

  scope "/" do
    pipe_through :public
    coherence_routes :public
  end

  scope "/" do
    pipe_through :protected
    coherence_routes :private
  end

  scope "/", ClassList do
    pipe_through :public # Use the default browser stack

    get "/", EntryController, :entry, as: :dir_entry
    post "/", EntryController, :create_entry, as: :dir_entry
  end

  scope "/admin", ClassList do
    pipe_through :protected

    resources "/buses", BusController
    get "/classes/list", ClassController, :list
    resources "/classes", ClassController
    resources "/addresses", AddressController
    resources "/students", StudentController
    get "/parents/email_list", ParentController, :email_list
    resources "/parents", ParentController
    resources "/entries", EntryController, only: [:index, :show, :delete]
    get "/directory", DirectoryController, :index
    get "/directory/download", DirectoryController, :download
    resources "/users", UserController
    get "/", StudentController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", ClassList do
  #   pipe_through :api
  # end
end
