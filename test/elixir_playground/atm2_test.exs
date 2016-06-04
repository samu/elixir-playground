defmodule Atm2Test do
  use ExUnit.Case
  alias ElixirPlayground.Atm2

  setup do
    {:ok, pid} = Atm2.start 10
    {:ok, %{atm: pid}}
  end

  test "it allows get the balance", %{atm: pid} do
    balance = Atm2.get_balance pid
    assert balance == 10
  end

  test "it allows deposit", %{atm: pid} do
    Atm2.deposit pid, 10
    balance = Atm2.get_balance pid
    assert balance == 20
  end

  test "it allows withdraw", %{atm: pid} do
    Atm2.withdraw pid, 5
    balance = Atm2.get_balance pid
    assert balance == 5
  end
end
