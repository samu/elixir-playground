defmodule Webshot.ServerTest do
  use ExUnit.Case

  setup do
    File.rm_rf("webshots")
    :ok
  end

  @timeout_message "snapshot didn't return in time"

  test "take_snapshot" do
    Webshot.Server.take_snapshot(self, "google.com")
    Webshot.Server.take_snapshot(self, "github.com")

    assert_receive({:ok, {"google.com", google_fn}}, 5000, @timeout_message)
    assert_receive({:ok, {"github.com", github_fn}}, 5000, @timeout_message)

    assert File.exists?("webshots/#{google_fn}")
    assert File.exists?("webshots/#{github_fn}")
  end
end
