defmodule AdventOfCode2017.MixProject do
  use Mix.Project

  def project do
    [
      app: :advent_of_code2017,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: escript(),
    
      # Docs
      name: "Advent of Code 2017 Solutions by @bericp1",
      source_url: "https://github.com/bericp1/advent-of-code-2017",
      docs: docs()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.16", only: :dev, runtime: false}
    ]
  end
  
  defp escript do
    [
      main_module: AdventOfCode2017,
      path: "_build/advent_of_code_2017"
    ]
  end
  
  defp docs do
    [
      main: "AdventOfCode2017",
      extras: ["README.md"],
      output: "docs"
    ]
  end
end
