defmodule Webshot.Pool do
  use GenServer

  def start_link(size) do
    GenServer.start_link(__MODULE__, {size, size}, name: __MODULE__)
  end

  def get do
    GenServer.call(__MODULE__, {:get, 1})
  end

  def put do
    GenServer.call(__MODULE__, {:put, 1})
  end

  def handle_call({:get, q}, _sender, {available, size}) do
    handle_pool_change(-1*q, available, size, &(&1 >= 0))
  end

  def handle_call({:put, q}, _sender, {available, size}) do
    handle_pool_change(1*q, available, size, &(&1 <= size))
  end

  defp handle_pool_change(quantity, available, size, condition) do
    n = available + quantity
    if condition.(n) do
      {:reply, true,  {n, size}}
    else
      {:reply, false, {available, size}}
    end
  end
end
