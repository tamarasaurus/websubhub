defmodule Websubhub.RemoveSubscription do
  alias Websubhub.Repo, as: Repo
  alias Websubhub.Subscription, as: Subscription

  @spec remove(map) :: map
  def remove(%{ "hub.callback" => callback_url, "hub.topic" => topic_url, "hub.mode" => "unsubscribe" }) do
    Repo.delete!(Repo.get_by(Subscription, callback_url: callback_url, topic_url: topic_url))
  end
end





