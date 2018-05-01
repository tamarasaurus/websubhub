defmodule Websubhub.RemoveSubscription do
  alias Websubhub.Repo, as: Repo
  alias Websubhub.Subscription, as: Subscription

  def remove(%{ "callback_url" => callback_url, "topic_url" => topic_url, "hub.mode" => "unsubscribe" }) do
    subscription = Repo.get_by(Subscription, callback_url: callback_url, topic_url: topic_url)

    Repo.delete!(subscription)
  end
end





