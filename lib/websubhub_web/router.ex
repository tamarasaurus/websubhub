defmodule WebsubhubWeb.Router do
  use WebsubhubWeb, :router

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

  scope "/", WebsubhubWeb do
    post "/", HubController, :validate
  end
end
