defmodule Scheduler.Server do
  use GenServer

  def start_link(client) do
    GenServer.start_link(__MODULE__, {client}, name: __MODULE__)
  end

  def do_work(work) do
    GenServer.call(__MODULE__, {:do_work, work})
  end

  def handle_call({:do_work, {work, client}}, _sender, state) do
    Task.Supervisor.async_nolink(Scheduler.Server.TaskSupervisor, fn ->
      result = work.()
      send(client, {:ok, result})
    end)

    {:reply, true, state}
  end
end
