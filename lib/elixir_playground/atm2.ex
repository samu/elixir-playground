defmodule ElixirPlayground.Atm2 do
  def start balance do
    Agent.start_link fn -> balance end
  end

  def deposit pid, amount do
    Agent.update pid, &(&1 + amount)
  end

  def withdraw pid, amount do
    Agent.update pid, &(&1 - amount)
  end

  def get_balance pid do
    Agent.get pid, &(&1)
  end
end
