defmodule Workers.WebshotConsumer.Supervisor do
  use Supervisor

  def start_link(client) do
    Supervisor.start_link(__MODULE__, {:ok, client}, name: __MODULE__)
  end

  def init({:ok, client}) do
    children = [
      worker(Workers.WebshotConsumer.Worker, [client]),
    ]

    supervise(children, strategy: :one_for_one)
  end
end
