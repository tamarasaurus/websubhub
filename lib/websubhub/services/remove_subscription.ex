defmodule Websubhub.RemoveSubscription do
  def remove(%{ "callback_url" => callback_url, "topic_url" => topic_url, "hub.mode" => "unsubscribe" }) do
    subscription = Websubhub.Repo.get_by(Websubhub.Subscription, callback_url: callback_url, topic_url: topic_url)
    Websubhub.Repo.delete!(subscription)
  end
end





