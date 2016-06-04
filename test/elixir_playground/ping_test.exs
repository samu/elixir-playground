defmodule PingTest do
  use ExUnit.Case

  test "it responds to a pong with a ping" do
    pid = spawn_link(ElixirPlayground.Ping, :start, [])
    send pid, {:pong, self}
    assert_receive :ping
    send pid, {:pong, self}
    assert_receive :ping
  end
end
