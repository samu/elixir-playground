defmodule Atm2Test do
  use ExUnit.Case
  alias ElixirPlayground.Atm2

  test "it allows get the balance" do
    {:ok, pid} = Atm2.start 10
    balance = Atm2.get_balance pid
    assert balance == 10
  end

  test "it allows deposit" do
    {:ok, pid} = Atm2.start 0
    Atm2.deposit pid, 10
    balance = Atm2.get_balance pid
    assert balance == 10
  end

  test "it allows withdraw" do
    {:ok, pid} = Atm2.start 100
    Atm2.withdraw pid, 10
    balance = Atm2.get_balance pid
    assert balance == 90
  end
end
