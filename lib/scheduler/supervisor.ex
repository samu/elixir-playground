defmodule Scheduler.Supervisor do
  use Supervisor

  def start_link(client) do
    Supervisor.start_link(__MODULE__, {:ok, client})
  end

  def init({:ok, client}) do
    children = [
      supervisor(Task.Supervisor, [[name: Scheduler.Server.TaskSupervisor]]),
      worker(Scheduler.Server, [client])
    ]
    opts = [strategy: :one_for_one]
    supervise(children, opts)
  end
end
