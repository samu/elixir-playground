defmodule Scheduler.Server do
  def start_link(name) do
    Task.Supervisor.start_link(name: name)
  end

  def do_work({work, client, name}) do
    Task.Supervisor.async_nolink(name, fn ->
      result = work.()
      send(client, {:ok, result})
    end)
    true
  end
end
