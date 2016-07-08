defmodule ServerTest do
  use ExUnit.Case

  setup do
    Scheduler.Server.start_link(self)
    :ok
  end

  test "it runs a function and sends the result to the client" do
    work = fn ->
      {:output, 1}
    end

    assert Scheduler.Server.do_work(work)
    assert_receive({:ok, {:output, 1}})
  end

  test "it runs tasks concurrently" do
    produce_work = fn input ->
      fn ->
        Process.sleep(10)
        input
      end
    end

    assert Scheduler.Server.do_work(produce_work.(1))
    assert Scheduler.Server.do_work(produce_work.(2))
    assert Scheduler.Server.do_work(produce_work.(3))

    assert_receive({:ok, 3}, 15)
  end
end
