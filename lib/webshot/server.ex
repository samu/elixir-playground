defmodule Webshot.Server do
  use GenServer
  alias Webshot.Pool

  def start_link(pool_size \\ 10) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
    Pool.start_link(pool_size)
  end

  def take_snapshot(sender, url) do
    GenServer.call(__MODULE__, {:take_snapshot, sender, url})
  end

  def handle_call({:take_snapshot, sender, url}, _sender, state) do
    if slot = Pool.get, do: schedule_task(url, sender)
    {:reply, slot, state}
  end

  defp schedule_task(url, sender) do
    Task.async fn ->
      result = run_command(url)
      send(sender, {:ok, result})
      Pool.put
    end
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
