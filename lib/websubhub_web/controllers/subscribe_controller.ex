defmodule WebsubhubWeb.SubscribeController do
  use WebsubhubWeb, :controller

  import Websubhub.CreateSubscription, only: [upsert: 1]
  import Websubhub.RemoveSubscription, only: [remove: 1]

  def subscribe(conn, %{"hub.callback" => callback, "hub.mode" => "subscribe", "hub.topic" => topic }) do
    if content_type(get_req_header(conn, "content-type")) do
      json conn, upsert(%{ callback_url: callback, topic_url: topic, expired_at: NaiveDateTime.utc_now() })
    else
      send_not_found(conn)
    end
  end

  def subscribe(conn, _), do: send_not_found(conn)

  def unsubscribe(conn, %{ "callback_url" => callback_url, "topic_url" => topic_url, "hub.mode" => "unsubscribe" }) do
    remove(%{ "callback_url" => callback_url, "topic_url" => topic_url, "hub.mode" => "unsubscribe" })
    put_status(conn, 410)
  end

  def unsubscribe(conn, _),do: send_not_found(conn)

  defp send_not_found(conn), do: put_status(conn, 404)
  defp content_type(["application/x-www-form-urlencoded; charset=utf-8"]), do: true
  defp content_type(_), do: false
end
