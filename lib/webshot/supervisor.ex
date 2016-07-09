defmodule Webshot.Supervisor do
  use Supervisor

  @scheduler_name Webshot.Scheduler

  def start_link(pool_size \\ 10) do
    Supervisor.start_link(__MODULE__, {:ok, pool_size}, name: __MODULE__)
  end

  def init({:ok, pool_size}) do
    children = [
      worker(Webshot.Pool, [pool_size]),
      worker(Webshot.Server, [@scheduler_name]),
      supervisor(Task.Supervisor, [[name: @scheduler_name]])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
