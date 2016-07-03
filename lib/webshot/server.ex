defmodule Webshot.Server do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def take_snapshot(sender, url) do
    GenServer.cast(__MODULE__, {:take_snapshot, sender, url})
  end

  def handle_cast({:take_snapshot, sender, url}, pool) do
    Task.async fn ->
      result = run_command(url)
      send(sender, {:ok, result})
    end
    {:noreply, []}
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
