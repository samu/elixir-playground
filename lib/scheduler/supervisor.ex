defmodule Scheduler.Supervisor do
  import Supervisor.Spec

  def start_link(client) do
    children = [
      supervisor(Task.Supervisor, [[name: Scheduler.Server.TaskSupervisor]]),
      supervisor(Scheduler.Server, [client])
    ]
    opts = [strategy: :one_for_one]
    Supervisor.start_link(children, opts)
  end
end
