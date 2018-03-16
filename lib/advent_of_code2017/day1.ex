defmodule AdventOfCode2017.Day1 do
  @moduledoc "Day 1: Inverse Captcha"

  def run() do
    IO.puts("\n--- Day 1: Inverse Captcha ---")
    ask_method() |> handle_method() |> solve_str() |> ok_result
  end

  defp ask_method() do
    IO.gets(:stdio, "Is the captcha stored in a file? ")
    |> String.trim()
    |> String.downcase()
    |> String.slice(0..0)
  end

  defp handle_method(method) do
    case method do
      "y" -> handle_file()
      "n" -> handle_input()
    end
  end

  defp handle_file() do
    IO.gets(:stdio, "What's the full or relative path to the file? ")
    |> String.trim()
    |> File.read!()
    |> String.trim()
  end

  defp handle_input() do
    IO.gets(:stdio, "What's the captcha (max 1024 characters)? ")
    |> String.trim()
  end

  defp ok_result(result) do
    {:ok, "Solution: #{result}"}
  end

  @doc """
  Circularly find the sum of all digits that match the next digit in the list
  """
  @spec solve(digits :: [integer, ...]) :: integer
  def solve(digits)

  # Circularize in a "dumb" way by just appending the first digit to the end of the list 
  def solve(digits) do
    solve(digits ++ [hd(digits)], 0)
  end

  # Begin solving a non empty list by checking if the first two elements match.
  # If so, 
  def solve([head | [next | _] = rest], sum) do
    sum = if head === next, do: sum + head, else: sum
    solve(rest, sum)
  end

  def solve(_, sum), do: sum

  @doc """
  Circularly find the sum of all digits that match the next digit in the string of digits
  """
  @spec solve_str(str :: charlist) :: integer
  def solve_str(str) do
    str_to_int_list(str) |> solve()
  end

  @spec str_to_int_list(str :: charlist) :: [integer, ...]
  def str_to_int_list(str) do
    :binary.bin_to_list(str) |> Enum.map(&byte_to_int(&1))
  end

  # Convert a utf8 byte representation of an integer into the integer
  def byte_to_int(byte) do
    case Integer.parse(<<byte::utf8>>) do
      {int, _} -> int
      _ -> raise ArgumentError, message: "`byte` does not represent utf8 integer character"
    end
  end
end
