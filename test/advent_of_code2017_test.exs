defmodule AdventOfCode2017Test do
  use ExUnit.Case
  doctest AdventOfCode2017

  test "run fails for negative numbers" do
    assert {:error, _} = AdventOfCode2017.run(-1)
  end

  test "run fails for too high positive numbers" do
    assert {:error, _} = AdventOfCode2017.run(100)
  end

  test "process_selection instructs to bail on proper quit string" do
    assert :bail = AdventOfCode2017.process_selection("q")
    assert :bail = AdventOfCode2017.process_selection("quit")
    assert :bail = AdventOfCode2017.process_selection("exit")
  end

  test "process_selection returns an error for non integers" do
    assert {:error, _} = AdventOfCode2017.process_selection("cats")
  end

  test "process_result instructs to continue for errors and non-errors" do
    assert :continue = AdventOfCode2017.process_result({:error, "Error!"})
    assert :continue = AdventOfCode2017.process_result({:ok, "Good to go!"})
  end
end
