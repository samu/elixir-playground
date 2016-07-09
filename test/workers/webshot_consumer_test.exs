defmodule Workers.WebshotConsumerTest do
  use ExUnit.Case

  @timeout 1000

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Database.Repo)
    Ecto.Adapters.SQL.Sandbox.mode(Database.Repo, {:shared, self()})

    File.rm_rf("webshots")
    File.mkdir("webshots")

    Workers.WebshotConsumer.Supervisor.start_link(self)
    :ok
  end

  describe "messages" do
    test "it does not send messages if nothing can be consumed" do
      refute_receive({:webshot_consumed, _, _})
    end

    test "it sends a message to the subscriber after consuming a file" do
      File.write("./webshots/file.png", "test")
      assert_receive({:webshot_consumed, "file.png", _}, @timeout)
      refute_receive _
    end

    test "it keeps polling and sends messages for every file" do
      File.write("./webshots/file1.png", "test")
      assert_receive({:webshot_consumed, "file1.png", _}, @timeout)
      refute_receive _

      File.write("./webshots/file2.png", "test")
      assert_receive({:webshot_consumed, "file2.png", _}, @timeout)
      refute_receive _
    end
  end

  describe "database upload" do
    test "it uploads the file to the db and returns the id" do
      File.write("./webshots/file1.png", "test")
      assert_receive({:webshot_consumed, "file1.png", id}, @timeout)
      refute_receive _
      Database.Repo.get!(Database.Snapshot, id)
    end
  end

  describe "cleanup" do
    test "it deletes the file from the directory after consumption" do
      File.write("./webshots/file1.png", "test")
      assert_receive({:webshot_consumed, "file1.png", id}, @timeout)
      refute_receive _
      refute File.exists?("./webshots/file1.png")
    end
  end
end
