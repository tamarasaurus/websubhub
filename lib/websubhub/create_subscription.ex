defmodule Websubhub.CreateSubscription do
  alias Websubhub.Subscription, as: Subscription
  import Websubhub.Repo, only: [insert: 2]
  import Map, only: [take: 2]

  @spec upsert(callback_url :: String.t, topic_url :: String.t) :: map
  def upsert(callback_url, topic_url) do
    changeset = Subscription.changeset(%Subscription{}, %{
      callback_url: callback_url,
      expired_at: NaiveDateTime.utc_now(),
      topic_url: topic_url
    })

    {:ok, subscription} =
      insert(
        changeset,
        on_conflict: [set: [
          callback_url: callback_url,
          topic_url: topic_url,
          expired_at: NaiveDateTime.utc_now()
        ]],
        conflict_target: [:callback_url, :topic_url]
      )

    take(subscription, [:topic_url, :callback_url, :expired_at])
  end
end
