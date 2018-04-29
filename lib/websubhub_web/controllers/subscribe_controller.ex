defmodule WebsubhubWeb.SubscribeController do
  use WebsubhubWeb, :controller

  @accepted_content_type ["application/x-www-form-urlencoded; charset=utf-8"]

  def subscribe(conn, %{"hub.callback" => callback, "hub.mode" => "subscribe", "hub.topic" => topic }) do
    if get_req_header(conn, "content-type") == @accepted_content_type do
      subscription = upsert_subscription(%{
        callback_url: callback,
        topic_url: topic,
        expired_at: NaiveDateTime.utc_now()
      })

      json(conn, subscription)
    else
      send_not_found(conn)
    end
  end

  def subscribe(conn, _params) do send_not_found(conn) end

  def unsubscribe(conn, %{ "callback_url" => callback_url, "topic_url" => topic_url, "hub.mode" => "unsubscribe" }) do
    subscription = Websubhub.Repo.get_by(Websubhub.Subscription, callback_url: callback_url, topic_url: topic_url)
    Websubhub.Repo.delete!(subscription)

    put_status(conn, 410)
  end

  def unsubscribe(conn, _params) do send_not_found(conn) end

  defp send_not_found(conn) do
    conn
      |> put_status(404)
      |> halt
  end

  defp upsert_subscription(params) do
    changeset = Websubhub.Subscription.changeset(%Websubhub.Subscription{}, params)

    {:ok, subscription} = Websubhub.Repo.insert(
      changeset,
      on_conflict: [set: [expired_at: NaiveDateTime.utc_now()]],
      conflict_target: [:callback_url, :topic_url]
    )

    Map.take(subscription, [:topic_url, :callback_url, :expired_at])
  end
end
