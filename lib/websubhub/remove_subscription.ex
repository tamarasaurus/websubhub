defmodule Websubhub.RemoveSubscription do
  alias Websubhub.Repo, as: Repo
  alias Websubhub.Subscription, as: Subscription

  # @TODO Add custom types for params
  @spec remove(map) :: map
  def remove(%{ "callback_url" => callback_url, "topic_url" => topic_url, "hub.mode" => "unsubscribe" }) do
    Repo.delete!(Repo.get_by(Subscription, callback_url: callback_url, topic_url: topic_url))
  end
end





