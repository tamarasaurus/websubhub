defmodule WebsubhubWeb.Router do
  use WebsubhubWeb, :router

  pipeline :api do
    plug :accepts, ["application/x-www-form-urlencoded"]
  end

  scope "/", WebsubhubWeb do
    post "/", HubController, :validate
  end
end
