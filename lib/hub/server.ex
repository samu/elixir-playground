defmodule Hub.Server do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, {}, name: __MODULE__)
  end

  def produce_webshot_consumer_action do
    fn file, entry ->
      __MODULE__.broadcast_webshot_ready()
    end
  end

  def broadcast_webshot_ready do
    GenServer.call(__MODULE__, {:webshot_ready, 1})
  end

  def handle_call({:webshot_ready, _}, _sender, _state) do
    IO.puts "received webshot ready but im not gonna do anything!"
    {:reply, true, _state}
  end
end
