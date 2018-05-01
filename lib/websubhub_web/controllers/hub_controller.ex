defmodule WebsubhubWeb.HubController do
  use WebsubhubWeb, :controller

  def endpoints(conn, %{}) do
    text conn, "endpoints"
  end

  def publish(conn, %{}) do
    distribute()
    json conn, "ok"
  end

  defp distribute do

  end
end
