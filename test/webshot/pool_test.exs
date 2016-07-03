defmodule Webshot.PoolTest do
  use ExUnit.Case

  test "it returns true if a slot is available" do
    Webshot.Pool.start_link(2)
    assert Webshot.Pool.get() == true
  end

  test "it decreases the available slots and returns false if none is available" do
    Webshot.Pool.start_link(2)
    assert Webshot.Pool.get() == true
    assert Webshot.Pool.get() == true
    assert Webshot.Pool.get() == false
  end

  test "it allows to put back available slots" do
    Webshot.Pool.start_link(1)
    assert Webshot.Pool.get() == true
    assert Webshot.Pool.get() == false
    Webshot.Pool.put()
    assert Webshot.Pool.get() == true
  end
end
