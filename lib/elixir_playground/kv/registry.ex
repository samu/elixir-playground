defmodule KV.Registry do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, :ok, [])
  end

  def create registry, bucket_name do
    GenServer.cast(registry, {:create, bucket_name})
  end

  def lookup registry, bucket_name do
    GenServer.call(registry, {:lookup, bucket_name})
  end

  # Server Callbacks
  def init :ok do
    {:ok, %{}}
  end

  def handle_call({:lookup, bucket_name}, _from, buckets) do
    {:reply, Map.fetch(buckets, bucket_name), buckets}
  end

  def handle_cast({:create, bucket_name}, buckets) do
    if Map.has_key?(buckets, bucket_name) do
      {:noreply, buckets}
    else
      {:ok, bucket} = KV.Bucket.start_link
      {:noreply, Map.put(buckets, bucket_name, bucket)}
    end
  end
end
