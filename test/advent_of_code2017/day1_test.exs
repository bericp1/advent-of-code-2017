defmodule AdventOfCode2017Test.Day1Test do
  use ExUnit.Case
  doctest AdventOfCode2017.Day1

  test "solve will solve the base cases in the puzzle definition" do
    assert AdventOfCode2017.Day1.solve_str("1122") === 3
    assert AdventOfCode2017.Day1.solve_str("1111") === 4
    assert AdventOfCode2017.Day1.solve_str("1234") === 0
    assert AdventOfCode2017.Day1.solve_str("91212129") === 9
  end
end
