defmodule Webshot.ServerTest do
  use ExUnit.Case

  setup do
    File.rm_rf("webshots")
    :ok
  end

  @timeout_message "snapshot didn't return in time"

  describe "take_snapshot" do
    setup do
      Webshot.Server.start_link
      :ok
    end

    test "schedules a webshot job and sends the results back" do
      Webshot.Server.take_snapshot(self, "google.com")
      Webshot.Server.take_snapshot(self, "github.com")

      assert_receive({:ok, {"google.com", google_fn}}, 5000, @timeout_message)
      assert_receive({:ok, {"github.com", github_fn}}, 5000, @timeout_message)

      assert File.exists?("webshots/#{google_fn}")
      assert File.exists?("webshots/#{github_fn}")
    end
  end

  describe "pooling" do
    setup do
      Webshot.Server.start_link(2)
      :ok
    end

    test "take_snapshot returns true if a webshot was scheduled" do
      assert Webshot.Server.take_snapshot(self, "google.com") == true
      assert_receive({:ok, _}, 5000, @timeout_message)
    end

    test "take_snapshot returns false if the webshot could not be scheduled" do
      assert Webshot.Server.take_snapshot(self, "google.com") == true
      assert Webshot.Server.take_snapshot(self, "google.com") == true
      assert Webshot.Server.take_snapshot(self, "google.com") == false
      assert_receive({:ok, _}, 5000, @timeout_message)
      assert_receive({:ok, _}, 5000, @timeout_message)
      refute_receive({:ok, _}, 5000, @timeout_message)
    end

    test "slots free up after a webshot has finished" do
      assert Webshot.Server.take_snapshot(self, "google.com") == true
      assert Webshot.Server.take_snapshot(self, "google.com") == true
      assert Webshot.Server.take_snapshot(self, "github.com") == false
      assert_receive({:ok, _}, 5000, @timeout_message)
      refute_receive({:ok, {"github.com", _}}, 5000, @timeout_message)
      assert Webshot.Server.take_snapshot(self, "github.com") == true
      assert_receive({:ok, _}, 5000, @timeout_message)
      assert_receive({:ok, {"github.com", _}}, 5000, @timeout_message)
    end
  end
end
