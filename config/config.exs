# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :websubhub,
  ecto_repos: [Websubhub.Repo]

# Configures the endpoint
config :websubhub, WebsubhubWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "erIVwPwA6eri6ZNprwioiWMK/SS+V2TwmAe+KEtWlHJarDwir8e4Do47gtjgRnk2",
  render_errors: [view: WebsubhubWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Websubhub.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

IO.inspect(System.get_env("PUBSUB_EMULATOR_HOST"))

config :kane,
  endpoint: System.get_env("PUBSUB_EMULATOR_HOST")

config :goth,
  json: "#{System.user_home()}/gcloud.json" |> File.read!

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
