defmodule Webshot.Server do
  use GenServer
  alias Webshot.Pool

  def start_link(scheduler_name) do
    GenServer.start_link(__MODULE__, {scheduler_name}, name: __MODULE__)
  end

  def take_snapshot(sender, url) do
    GenServer.call(__MODULE__, {:take_snapshot, sender, url})
  end

  def handle_call({:take_snapshot, sender, url}, _sender, {scheduler_name} = state) do
    if slot = Pool.get, do: schedule_task(url, sender, scheduler_name)
    {:reply, slot, state}
  end

  defp schedule_task(url, sender, scheduler_name) do
    work = fn ->
      result = run_command(url)
      Pool.put
      result
    end
    Scheduler.Server.do_work({work, sender, scheduler_name})
  end

  defp run_command(url) do
    timestamp = :os.system_time(:milli_seconds)
    filename = "#{timestamp}#{url}.png"
    System.cmd("node", ["-e", command(url, filename)])
    {url, filename}
  end

  defp command(url, filename) do
    """
    var webshot = require('webshot');
    webshot('#{url}', './webshots/#{filename}', function(err) {});
    """
  end
end
