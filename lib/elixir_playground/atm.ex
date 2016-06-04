defmodule ElixirPlayground.Atm do
  def start balance do
    manage balance
  end

  def manage balance do
    receive do
      {:deposit, amount} ->
        manage balance + amount
      {:check, receiver} ->
        send receiver, balance
        manage balance
    end
  end
end
