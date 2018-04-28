defmodule WebsubhubWeb.SubscriptionController do
  use WebsubhubWeb, :controller

  # create and store subscription in the db
  def subscribe(conn, %{
      "hub.callback" => callback,
       # subscribe
      "hub.mode" => mode,
       # subscription_id
      "hub.topic" => topic,
       # store in the hub
      "hub.secret" => secret
  }) do
    # return the success of the subscription
    # store the subscription in the database
    json conn, %{callback: callback, mode: mode, topic: topic, secret: secret}
  end

  # unsubscribe
  def unsubscribe(conn, %{ "subscription_id" => subscription_id }) do
    # delete subscription from the database
    # return 410
    text conn, "unsubscribed from #{subscription_id}"
  end
end
