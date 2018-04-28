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
    {:ok}
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
