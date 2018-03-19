defmodule AdventOfCode2017Test.Day1Test do
  use ExUnit.Case
  doctest AdventOfCode2017.Day1

  alias AdventOfCode2017.Day1.{Part1, Part2}

  test "part 1 will solve the base cases in the puzzle definition" do
    assert Part1.solve_str("1122") === 3
    assert Part1.solve_str("1111") === 4
    assert Part1.solve_str("1234") === 0
    assert Part1.solve_str("91212129") === 9
  end

  test "part 2 will solve the base cases in the puzzle definition" do
    assert Part2.solve_str("1212") === 6
    assert Part2.solve_str("1221") === 0
    assert Part2.solve_str("123425") === 4
    assert Part2.solve_str("123123") === 12
    assert Part2.solve_str("12131415") === 4
  end
end
