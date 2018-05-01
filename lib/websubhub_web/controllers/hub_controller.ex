defmodule WebsubhubWeb.HubController do
  use WebsubhubWeb, :controller
  import Websubhub.DistributeContent, only: [distribute: 1]

  def endpoints(conn, %{}), do: text conn, "endpoints"

  def publish(conn, %{}) do
    distribute(1)
    json conn, "ok"
  end
end
