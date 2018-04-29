defmodule WebsubhubWeb.SubscribeController do
  use WebsubhubWeb, :controller

  def subscribe(conn, %{
      "hub.callback" => callback,
      "hub.mode" => "subscribe",
      "hub.topic" => topic,
      "hub.secret" => secret
  }) do
    if get_req_header(conn, "content-type") == ["application/x-www-form-urlencoded; charset=utf-8"] do
      subscription = upsert_subscription(%{
        callback_url: callback,
        topic_url: topic,
        expired_at: NaiveDateTime.utc_now
      })

      json conn, subscription
    else
      send_not_found(conn)
    end
  end

  def subscribe(conn, _params) do send_not_found(conn) end

  defp send_not_found(conn) do
    conn
      |> put_status(404)
      |> halt
  end

  def unsubscribe(conn, %{
    "subscription_id" => subscription_id,
    "hub.mode" => "unsubscribe"
  }) do
    send_resp(conn, 410, "Unsubscribed from #{subscription_id}")
  end

  defp upsert_subscription(params) do
    changeset = Websubhub.Subscription.changeset(%Websubhub.Subscription{}, params)

    {:ok, subscription} = Websubhub.Repo.insert(
      changeset,
      on_conflict: [set: [expired_at: NaiveDateTime.utc_now]],
      conflict_target: [:callback_url, :topic_url]
    )

    subscription
      |> Map.take([:topic_url, :callback_url, :expired_at])
  end
end
