defmodule ElixirPlayground do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(Endpoints.Server, []),
      supervisor(Database.Repo, [])
    ]

    opts = [strategy: :one_for_one, name: ElixirPlayground.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
