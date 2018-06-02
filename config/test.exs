use Mix.Config

config :websubhub, WebsubhubWeb.Endpoint,
  http: [port: 4001],
  server: false

config :logger, level: :warn

config :websubhub, Websubhub.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "",
  database: "websubhub_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
