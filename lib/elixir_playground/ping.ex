defmodule ElixirPlayground.Ping do
  def start do
    receive do
      {:pong, receiver} -> send receiver, :ping
    end
    start
  end
end
