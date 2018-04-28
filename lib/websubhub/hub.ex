defmodule Websubhub.Hub do
  use GenServer

  def start_link() do
    pull(%{})
    GenServer.start_link(__MODULE__, [], name: Hub)
  end

  def init(args) do
    {:ok, args}
  end

  def pull(_) do
    IO.inspect('pull messages from the gpubsub queue')

    subscription = %Kane.Subscription{topic: %Kane.Topic{name: System.get_env("PUBSUB_TOPIC")}}
    {:ok, messages} = Kane.Subscription.pull(subscription)

    Enum.each messages, fn(mess)->
      process_message(mess)
    end

    Kane.Subscription.ack(subscription, messages)
  end

  def process_message(message) do
    IO.inspect(message);
  end

  def distribute(_) do
    # get the message from the queue
    # match against stored subscription
    # call the hub.callback url
  end
end
