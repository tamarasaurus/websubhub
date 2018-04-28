defmodule WebsubhubWeb.SubscriptionController do
  use WebsubhubWeb, :controller

  def subscribe(conn, %{
      "hub.callback" => callback,
      "hub.mode" => "subscribe",
      "hub.topic" => topic,
      "hub.secret" => secret
  }) do
    if get_req_header(conn, "content-type") == ["application/x-www-form-urlencoded; charset=utf-8"] do
      json conn, %{callback: callback, mode: "subscribe", topic: topic, secret: secret}
    end

    send_not_found(conn)
  end

  def subscribe(conn, _params) do
    send_not_found(conn)
  end

  defp send_not_found(conn) do
    conn
      |> send_resp(404, "Not found")
      |> halt()
  end

  def unsubscribe(conn, %{
    "subscription_id" => subscription_id,
    "hub.mode" => "unsubscribe"
  }) do
    send_resp(conn, 410, "Unsubscribed from #{subscription_id}")
  end
end
