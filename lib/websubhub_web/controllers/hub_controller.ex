defmodule WebsubhubWeb.HubController do
  use WebsubhubWeb, :controller

  def endpoints(conn, %{}) do
    text conn, "endpoints"
  end

  def distribute(conn, %{}) do
    json conn, "ok"
  end
end
