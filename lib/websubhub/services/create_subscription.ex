defmodule Websubhub.CreateSubscription do
  def upsert(params) do
    changeset = Websubhub.Subscription.changeset(%Websubhub.Subscription{}, params)

    {:ok, subscription} = Websubhub.Repo.insert(
      changeset,
      on_conflict: [set: [expired_at: NaiveDateTime.utc_now()]],
      conflict_target: [:callback_url, :topic_url]
    )

    Map.take(subscription, [:topic_url, :callback_url, :expired_at])
  end
end


