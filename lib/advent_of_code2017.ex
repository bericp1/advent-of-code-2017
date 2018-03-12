defmodule AdventOfCode2017 do
  @moduledoc "A solution set for the advent of code 2017."

  @max_implemented_day 1
  @bail_strings ["q", "quit", "exit"]
  @days %{1 => AdventOfCode2017.Day1}

  # "Log a regular message to stdout"
  defp log(message), do: IO.puts(message)

  # "Log an error messahe to stderr"
  defp log_error(error), do: IO.puts(:stderr, error)

  @doc "Error case when an invalid day is provided (negative, 0, or hasn't been implemented yet)."
  def run(day) when day > @max_implemented_day or day < 1 do
    {:error, "Please provide a day between 1 and #{@max_implemented_day}"}
  end

  @doc "Run a day's puzzle by number and executing its run method."
  def run(day) do
    case day do
      1 -> @days[day].run()
      _ -> {:error, "Invalid day provided."}
    end
  end

  @doc "Error case when no day is provided."
  def run(), do: {:error, "Must provide a day to run."}

  def process_selection(selection) do
    if Enum.member?(@bail_strings, selection) do
      :bail
    else
      case Integer.parse(selection) do
        {day, _} ->
          run(day)

        _ ->
          {:error,
           "Please provide a day in integer format (i.e. '1' === 'Day 1') or `q`/`quit`/`exit` to quit."}
      end
    end
  end

  def select() do
    IO.gets(:stdio, "\nWhat day should be ran? ") |> String.trim()
  end

  def process_result({:ok, result}) do
    log(result)
    :continue
  end

  def process_result({:error, result}) do
    log_error(result)
    :continue
  end

  def process_result(fwd), do: fwd

  def loop() do
    case select() |> process_selection() |> process_result() do
      :bail ->
        0

      :continue ->
        loop()

      bad_result ->
        log_error("Unknown result: #{bad_result}")
        1
    end
  end

  def main(_) do
    loop()
  end
end
