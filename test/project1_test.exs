defmodule Project1Test do
  use ExUnit.Case
  doctest Project1

  test "greets the world" do
    assert Project1.hello() == :world
  end
end
