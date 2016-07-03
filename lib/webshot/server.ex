defmodule Webshot.Server do
  def take_snapshot(sender, url) do
    Task.async fn ->
      result = run_command(url)
      send(sender, {:ok, result})
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
