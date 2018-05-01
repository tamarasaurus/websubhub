defmodule WebsubhubWeb.HubController do
  use WebsubhubWeb, :controller
  import Websubhub.DistributeContent, only: [distribute: 0]

  def endpoints(conn, %{}) do
    text conn, "endpoints"
  end

  def publish(conn, %{}) do
    distribute()
    json conn, "ok"
  end
end
