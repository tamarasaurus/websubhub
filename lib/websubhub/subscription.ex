defmodule Websubhub.Subscription do
  use Ecto.Schema
  import Ecto.Changeset

  schema "subscriptions" do
    field :callback_url, :string
    field :expired_at, :date
    field :topic_url, :string

    timestamps()
  end

  @doc false
  def changeset(subscription, attrs) do
    subscription
    |> cast(attrs, [:topic_url, :callback_url, :expired_at])
    |> validate_required([:topic_url, :callback_url, :expired_at])
  end
end
