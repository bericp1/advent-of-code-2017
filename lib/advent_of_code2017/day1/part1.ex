defmodule AdventOfCode2017.Day1.Part1 do
  @moduledoc """
  Day 1: Inverse Captcha: Part 1 (next digit)
  """

  alias AdventOfCode2017.Day1

  @doc """
  Circularly find the sum of all digits that match the next digit in the list
  """
  @spec solve(digits :: [integer, ...]) :: integer
  def solve(digits) do
    digits
    |> Enum.with_index()
    |> Enum.reduce(0, fn {digit, index}, sum ->
      sum +
        Day1.compare_digits(
          digits,
          digit,
          index + 1
        )
    end)
  end

  @doc """
  Circularly find the sum of all digits that match the next digit in a string of digits
  """
  @spec solve_str(digits :: charlist) :: integer
  def solve_str(digits) do
    digits
    |> Day1.str_to_int_list()
    |> solve
  end
end
