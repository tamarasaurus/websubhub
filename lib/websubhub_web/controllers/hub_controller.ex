defmodule WebsubhubWeb.HubController do
  use WebsubhubWeb, :controller
  import Websubhub.DistributeContent, only: [distribute: 1]

  @spec endpoints(conn :: Plug.Conn.t, params :: map) :: Plug.Conn.t
  def endpoints(conn, %{}), do: text conn, "endpoints"

  @spec publish(conn :: Plug.Conn.t, params :: map) :: Plug.Conn.t
  def publish(conn, %{}) do
    distribute(1)
    json conn, "ok"
  end
end
