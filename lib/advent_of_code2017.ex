defmodule AdventOfCode2017 do
  @moduledoc "A solution set for the advent of code 2017."

  @max_implemented_day 1
  @bail_strings ["q", "quit", "exit"]
  @days %{1 => AdventOfCode2017.Day1}

  # Log a regular message to stdout
  defp log(message), do: IO.puts(message)

  # Log an error messahe to stderr
  defp log_error(error), do: IO.puts(:stderr, error)

  @doc "Run a day's puzzle by number and executing its run method."
  @spec run(integer) :: tuple
  def run(day)

  # Error case when an invalid day is provided (negative, 0, or hasn't been implemented yet).
  def run(day) when day > @max_implemented_day or day < 1 do
    {:error, "Please provide a day between 1 and #{@max_implemented_day}"}
  end

  # Handle day in valid range
  def run(day) do
    case day do
      1 -> @days[day].run()
      _ -> {:error, "Invalid day provided."}
    end
  end

  @doc """
  Process a selection received from `select/0`.

  `selection` should be one of:

    - a valid number matching an implemented advent "day" (a number between 1 and
      #{@max_implemented_day})
    - one of #{@bail_strings}
  """
  @spec process_selection(charlist) :: atom | tuple
  def process_selection(selection)

  # Handle bail selection
  def process_selection(selection) when selection in @bail_strings do
    :bail
  end

  # Handle number selection by running and returning the result of the corrresponding day
  def process_selection(selection) do
    case Integer.parse(selection) do
      {day, _} ->
        run(day)

      _ ->
        {:error,
         "Please provide a day in integer format (i.e. '1' === 'Day 1') or `q`/`quit`/`exit` to quit."}
    end
  end

  @doc "Read in a selection from stdin."
  @spec select() :: charlist
  def select() do
    IO.gets(:stdio, "\nWhat day should be ran? ") |> String.trim()
  end

  @doc """
  Process a result from `process_selection/1` for use in `loop/0`.

  Will produce side effects.
    
  `result` should be one of the following:

    - `{:ok, message}`: run completed successfully and has a message to share with the user. Loop should continue.
    - `{:error, message}`: run failed for some reason and has a message about the error to share with the user.
      Loop should continue.
    - Anything else (e.g. `:bail` or `:continue`) will be returned directly.
  """
  @spec process_result(tuple | atom) :: atom
  def process_result(result)

  # Process an affirmative selection result by logging the result and signaling to the loop to continue.
  def process_result({:ok, result}) do
    log(result)
    :continue
  end

  # Process an erroneous selection result by logging the error and signaling to the loop to continue.
  def process_result({:error, result}) do
    log_error(result)
    :continue
  end

  # Forward all other selection results straight through without transforming them.
  def process_result(fwd), do: fwd

  @doc """
  Main loop. Ask the user what they want to do, process the selection, and process its result.

  Will accept the following results:

    - `:bail` will bail out of the loop and exit with a zero (successful) status code
    - `:continue` will restart the loop
  """
  @spec loop() :: integer
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

  @doc "Called as the entry point by escript."
  def main(_args) do
    loop()
  end
end
