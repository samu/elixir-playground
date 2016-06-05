defmodule ElixirPlayground.KV.RegistryTest do
  use ExUnit.Case, async: true

  setup context do
    {:ok, registry} = ElixirPlayground.KV.Registry.start_link(context.test)
    {:ok, registry: registry}
  end

  test "spawns buckets", %{registry: registry} do
    assert ElixirPlayground.KV.Registry.lookup(registry, "shopping") == :error

    ElixirPlayground.KV.Registry.create(registry, "shopping")
    assert {:ok, bucket} = ElixirPlayground.KV.Registry.lookup(registry, "shopping")

    KV.Bucket.put(bucket, "milk", 1)
    assert KV.Bucket.get(bucket, "milk") == 1
  end

  test "removes buckets on exit", %{registry: registry} do
    ElixirPlayground.KV.Registry.create(registry, "shopping")
    {:ok, bucket} = ElixirPlayground.KV.Registry.lookup(registry, "shopping")
    Agent.stop(bucket)
    assert ElixirPlayground.KV.Registry.lookup(registry, "shopping") == :error
  end

  test "removes bucket on crash", %{registry: registry} do
    ElixirPlayground.KV.Registry.create(registry, "shopping")
    {:ok, bucket} = ElixirPlayground.KV.Registry.lookup(registry, "shopping")

    # Stop the bucket with non-normal reason
    Process.exit(bucket, :shutdown)

    # Wait until the bucket is dead
    ref = Process.monitor(bucket)
    assert_receive {:DOWN, ^ref, _, _, _}

    assert ElixirPlayground.KV.Registry.lookup(registry, "shopping") == :error
  end
end
