defmodule AdventOfCode2017.Day1 do
  @moduledoc "Day 1: Inverse Captcha"

  alias AdventOfCode2017.Day1.{Part1, Part2}

  @doc """
  Run the Day 1 puzzle to gather input from the user.
  """
  def run() do
    IO.puts("\n--- Day 1: Inverse Captcha ---")

    ask()
    |> handle()
    |> ok_result()
  end

  # Ask the user if we should solve for part 1 or part 2.
  defp ask_part() do
    IO.gets(:stdio, "Is this a part 1 or a part 2 captcha? ")
    |> String.trim()
    |> String.downcase()
    |> convert_part()
  end

  # Sanitize the part input that was received.
  defp convert_part(str) do
    cond do
      str == "one" -> 1
      str == "1" -> 1
      str == "two" -> 2
      str == "2" -> 2
      true -> raise ArgumentError, message: "Part must be one or two."
    end
  end

  # Ask the user if we should look in a file or gather from stdin
  defp ask_method() do
    IO.gets(:stdio, "Is the captcha stored in a file (y/n)? ")
    |> String.trim()
    |> String.downcase()
    |> String.slice(0..0)
  end

  # Ask for both part and method and return in a map
  defp ask() do
    %{
      "part" => ask_part(),
      "method" => ask_method()
    }
  end

  # Handle the answer provided for the `ask_method/0`
  defp handle_method(method) do
    case method do
      "y" -> handle_file()
      "n" -> handle_input()
    end
  end

  # If the file method was used, ask for the file, read it in, sanitize it, and return it.
  defp handle_file() do
    IO.gets(:stdio, "What's the full or relative path to the file? ")
    |> String.trim()
    |> File.read!()
    |> String.trim()
  end

  # If the input method was used, read in, sanitize, and return it.
  defp handle_input() do
    IO.gets(:stdio, "What's the captcha (max 1024 characters)? ")
    |> String.trim()
  end

  # Actually perform the handling once we've asked both important questions.
  defp handle(%{"part" => part, "method" => method}) do
    method
    |> handle_method()
    |> str_to_int_list()
    |> handle_solve(part)
  end

  # Solve the input, passing it to the appropriate part.
  defp handle_solve(input, part) do
    case part do
      1 -> Part1.solve(input)
      2 -> Part2.solve(input)
    end
  end

  # Generate an ok result
  defp ok_result(result) do
    {:ok, "Solution: #{result}"}
  end

  @doc """
  Convert a string (charlist) to a list of integers.
  """
  @spec str_to_int_list(str :: charlist) :: [integer, ...]
  def str_to_int_list(str) do
    :binary.bin_to_list(str)
    |> Enum.map(&byte_to_int/1)
  end

  @doc """
  Convert a utf8 byte representation of an integer into the integer it represents.
  """
  @spec byte_to_int(char) :: integer
  def byte_to_int(byte) do
    case Integer.parse(<<byte::utf8>>) do
      {int, _} -> int
      _ -> raise ArgumentError, message: "`byte` does not represent utf8 integer character"
    end
  end

  @doc """
  `Enum.at/2` but will wrap around if `index` is greater than the `length/1` of `list`.
  """
  @spec at_wraparound(list :: [...], index :: integer) :: any
  def at_wraparound(list, index) do
    Enum.at(list, rem(index, length(list)))
  end

  @doc """
  Compares two digits and if they are equal, returns their value. Otherwise returns `0`.

  See also `compare_digits/3`
  """
  @spec compare_digits(digit_a :: integer, digit_b :: integer) :: integer
  def compare_digits(digit_a, digit_b) do
    if digit_a == digit_b, do: digit_a, else: 0
  end

  @doc """
  Given a list, will compare `digit_a` with the digit at `index_b`, returning their value if equivleant and `0`
  otherwise.

  See `compare_digits/2`, `at_wraparound/2`
  """
  @spec compare_digits(list :: [integer, ...], digit_a :: integer, index_b :: integer) :: integer
  def compare_digits(digits, digit_a, index_b) do
    compare_digits(
      digit_a,
      at_wraparound(digits, index_b)
    )
  end
end
