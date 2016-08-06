defmodule Coders.Mixfile do
  use Mix.Project

  def project do
    [app: :coders,
     version: "0.1.0",
     elixir: "~> 1.3",
     escript: escript_config,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpotion, :table_rex]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      { :httpotion,  "~> 3.0" },
      { :json,       "~> 0.3.3" },
      { :table_rex,  "~> 0.8.1" } 
    ]
  end

  defp escript_config do
    [ main_module: Coders.CLI ]
  end
end
