defmodule Web.Router do
  use Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    # plug :protect_from_forgery
    plug :put_secure_browser_headers
    # plug Snippster.Plugs.CurrentUser
  end

  scope "/", Web do
    pipe_through :browser

    # get "/", PageController, :index

    post "/snapshot", Controller, :snapshot
  end
end
