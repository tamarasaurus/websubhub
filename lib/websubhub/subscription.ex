defmodule Websubhub.Subscription do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Poison.Encoder, only: [:callback_url, :expired_at, :topic_url]}
  schema "subscriptions" do
    field :callback_url, :string, primary_key: true
    field :expired_at, :naive_datetime
    field :topic_url, :string, primary_key: true

    timestamps()
  end

  @doc false
  def changeset(subscription, attrs) do
    subscription
    |> cast(attrs, [:topic_url, :callback_url, :expired_at])
    |> validate_required([:topic_url, :callback_url, :expired_at])
  end
end
