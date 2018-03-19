defmodule AdventOfCode2017.Day1.Part2 do
  @moduledoc """
  Day 1: Inverse Captcha: Part 2 (digit halfway around)
  """

  alias AdventOfCode2017.Day1

  @doc """
  Circularly find the sum of all digits in a list of digits that match the digit halfway around the list.

  See also `solve_str/1`
  """
  @spec solve(digits :: [integer, ...]) :: integer
  def solve(digits) do
    halfway = div(length(digits), 2)

    digits
    |> Enum.with_index()
    |> Enum.reduce(0, fn {digit, index}, sum ->
      sum +
        Day1.compare_digits(
          digits,
          digit,
          index + halfway
        )
    end)
  end

  @doc """
  Circularly find the sum of all digits in a string of digits that match the digit halfway around the string.

  See `solve/1`
  """
  @spec solve_str(digits :: charlist) :: integer
  def solve_str(digits) do
    digits
    |> Day1.str_to_int_list()
    |> solve
  end
end
