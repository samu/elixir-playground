defmodule ElixirPlayground do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(Server.Endpoint, []),
      supervisor(Upload.Repo, []),
      # supervisor(Scheduler.Supervisor, [:test])
      # ,
      # supervisor(Task.Supervisor, [[name: ElixirPlayground.TaskSupervisor]])
    ]

    opts = [strategy: :one_for_one, name: ElixirPlayground.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
