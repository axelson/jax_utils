defmodule JaxUtilsTest do
  use ExUnit.Case
  doctest JaxUtils

  test "greets the world" do
    assert JaxUtils.hello() == :world
  end
end
