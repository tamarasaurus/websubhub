defmodule Websubhub.Application do
  use Application

  # [applications: [:kane]]

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(Websubhub.Repo, []),
      supervisor(WebsubhubWeb.Endpoint, []),
      worker(Websubhub.Hub, [])
    ]

    opts = [strategy: :one_for_one, name: Websubhub.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    WebsubhubWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
