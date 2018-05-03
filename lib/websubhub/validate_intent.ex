defmodule Websubhub.ValidateIntent do
  use GenServer

  import Websubhub.CreateSubscription, only: [upsert: 2]

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, [])
  end

  def init(_) do
    {:ok, nil}
  end

  def handle_call({:validate_intent, params}, _from, state) do
    callback = params["hub.callback"]
    subscription = Map.merge(params, %{"hub.challenge" => "123"})

    HTTPoison.start
    url = "#{callback}/?#{URI.encode_query(subscription)}"
    handle_response(HTTPoison.get(url), subscription)

    {:reply, :ok, state}
  end

  defp handle_response({:ok, response}, subscription) do
    challenge = subscription["hub.challenge"]

    if (response.body == challenge) do
        upsert(subscription["hub.callback"], subscription["hub.topic"]);
    end

    nil
  end

  defp handle_response({:error, response}, subscription) do
    IO.inspect(response)
  end

end
