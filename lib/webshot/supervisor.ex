defmodule Webshot.Supervisor do
  use Supervisor

  @scheduler_name Webshot.Scheduler

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    children = [
      worker(Webshot.Server, [@scheduler_name]),
      supervisor(Task.Supervisor, [[name: @scheduler_name]])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
