defmodule Websubhub.Repo.Migrations.CreateSubscriptions do
  use Ecto.Migration

  def change do
    create table(:subscriptions) do
      add :topic_url, :string
      add :callback_url, :string
      add :expired_at, :naive_datetime

      timestamps()
    end

    create unique_index(:subscriptions, [:topic_url, :callback_url], name: :index_subscriptions_on_topic_and_callback)
  end

  def down do
    drop index(:subscriptions, [:topic_url, :callback_url], name: :index_subscriptions_on_topic_and_callback)
  end
end
