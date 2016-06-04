defmodule KV.Bucket do
  def start_link do
    Agent.start_link fn -> %{} end
  end

  def get receiver, item do
    Agent.get receiver, &Map.get(&1, item)
  end

  def put receiver, item, quantity do
    Agent.update receiver, &Map.put(&1, item, 3)
  end

  def delete receiver, item do
    Agent.get_and_update receiver, &Map.pop(&1, item)
  end
end
