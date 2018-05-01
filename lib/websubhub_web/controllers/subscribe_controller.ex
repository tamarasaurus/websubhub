defmodule WebsubhubWeb.SubscribeController do
  use WebsubhubWeb, :controller

  import Websubhub.CreateSubscription, only: [upsert: 2]
  import Websubhub.RemoveSubscription, only: [remove: 1]

  @spec subscribe(conn :: Plug.Conn.t, params :: map) :: Plug.Conn.t
  def subscribe(conn, %{"hub.callback" => callback, "hub.mode" => "subscribe", "hub.topic" => topic }) do
    if content_type(get_req_header(conn, "content-type")) do
      json conn, upsert(callback, topic)
    else
      send_not_found(conn)
    end
  end

  def subscribe(conn, _), do: send_not_found(conn)

  @spec unsubscribe(conn :: Plug.Conn.t, params :: map) :: Plug.Conn.t
  def unsubscribe(conn, %{ "callback_url" => _, "topic_url" => _, "hub.mode" => "unsubscribe" } = params) do
    remove(params)
    put_status conn, 410
  end

  def unsubscribe(conn, _),do: send_not_found(conn)

  @spec send_not_found(conn :: Plug.Conn.t) :: Plug.Conn.t
  defp send_not_found(conn), do: put_status(conn, 404)

  @spec content_type([ String.t ]) :: boolean
  defp content_type(["application/x-www-form-urlencoded; charset=utf-8"]), do: true
  defp content_type(_), do: false
end
