defmodule Websubhub.Application do
  use Application

  defp poolboy_config do
    [
      {:name, {:local, :worker}},
      {:worker_module, Websubhub.ValidateIntent},
      {:size, 5},
      {:max_overflow, 2}
    ]
  end

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(Websubhub.Repo, []),
      supervisor(WebsubhubWeb.Endpoint, []),
      :poolboy.child_spec(:worker, poolboy_config())
    ]

    opts = [strategy: :one_for_one, name: Websubhub.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    WebsubhubWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
