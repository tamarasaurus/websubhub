defmodule Websubhub.Subscription do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Poison.Encoder, only: [:callback_url, :expired_at, :topic_url]}
  @primary_key {:id, :id, autogenerate: true}
  schema "subscriptions" do
    field :callback_url, :string
    field :topic_url, :string
    field :expired_at, :naive_datetime

    timestamps()
  end

  @doc false
  def changeset(subscription, attrs) do
    subscription
    |> cast(attrs, [:topic_url, :callback_url, :expired_at])
    |> validate_required([:topic_url, :callback_url, :expired_at])
    |> unique_constraint(:topic_url, name: :index_subscriptions_on_topic_and_callback)
  end
end
