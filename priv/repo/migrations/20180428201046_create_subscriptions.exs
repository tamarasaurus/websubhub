defmodule Websubhub.Repo.Migrations.CreateSubscriptions do
  use Ecto.Migration

  def change do
    create table(:subscriptions) do
      add :topic_url, :string
      add :callback_url, :string
      add :expired_at, :date

      timestamps()
    end

  end
end
