defmodule Tychron.API.MixProject do
  use Mix.Project

  def project do
    [
      app: :tychron_api,
      version: "0.1.0",
      elixir: "~> 1.10",
      elixirc_paths: elixirc_paths(Mix.env()),
      elixirc_options: [
        warnings_as_errors: true,
      ],
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      source_url: "https://github.com/Tychron/tychron_api",
      homepage_url: "https://github.com/Tychron/tychron_api",
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      # ULID format, just for the typespec
      {:ecto_ulid, "~> 0.3"},
      # Parse accept headers
      {:accept, "~> 0.3.5"},
      # Needed for some utility functions
      {:plug, "~> 1.6"},
      # JSON Parser
      {:jason, "~> 1.0"},
      # Data Modelling
      {:ecto, "~> 3.0"},
      # HTTP Client
      {:httpoison, "~> 2.0"},

      {:bypass, "~> 1.0 or ~> 2.1", [only: :test]},
    ]
  end
end
