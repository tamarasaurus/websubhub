defmodule Websubhub.Repo.Migrations.CreateSubscriptions do
  use Ecto.Migration

  def change do
    create table(:subscriptions, primary_key: false) do
      add :topic_url, :string, primary_key: true
      add :callback_url, :string, primary_key: true
      add :expired_at, :naive_datetime
      add :id, :binary_id, autogenerate: true

      timestamps()
    end

  end
end
