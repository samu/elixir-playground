defmodule Workers.WebshotConsumer.Supervisor do
  use Supervisor

  def start_link(action) do
    Supervisor.start_link(__MODULE__, {:ok, action}, name: __MODULE__)
  end

  def init({:ok, action}) do
    children = [
      worker(Workers.WebshotConsumer.Worker, [action]),
    ]

    supervise(children, strategy: :one_for_one)
  end
end
