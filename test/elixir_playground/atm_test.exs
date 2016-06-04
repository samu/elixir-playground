defmodule AtmTest do
  use ExUnit.Case

  test "it allows to deposit" do
    pid = spawn_link(ElixirPlayground.Atm, :start, [0])
    send pid, {:deposit, 10}
    send pid, {:check, self}
    assert_receive 10
  end
end
