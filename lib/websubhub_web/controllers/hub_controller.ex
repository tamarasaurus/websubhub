defmodule WebsubhubWeb.HubController do
  use WebsubhubWeb, :controller

  @spec validate(conn :: Plug.Conn.t, params :: map) :: Plug.Conn.t
  def validate(conn, %{"hub.mode" => "publish"}) do
    send_resp(conn, 202, "")
  end

  def validate(conn, %{"hub.callback" => _, "hub.mode" => "subscribe", "hub.topic" => _ } = params) do
    start_worker(params)
    send_resp(conn, 202, "")
  end

  def validate(conn, %{ "hub.callback" => _, "hub.topic" => _, "hub.mode" => "unsubscribe" } = params) do
    start_worker(params)
    send_resp(conn, 410, "")
  end

  def validate(conn, _), do: send_not_found(conn)

  @spec send_not_found(conn :: Plug.Conn.t) :: Plug.Conn.t
  defp send_not_found(conn), do:  send_resp(conn, 404, "")
  defp start_worker(params) do
    :poolboy.transaction(
      :worker,
      fn pid -> GenServer.call(pid, {:validate_intent, params}) end,
      60000
    )
  end
end
