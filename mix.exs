defmodule JaxUtils.MixProject do
  use Mix.Project

  def project do
    [
      app: :jax_utils,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {JaxUtils.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:cachex, ">= 0.0.0", optional: true},
      {:dotenv_parser, "~> 2.0"},
      {:jason, "~> 1.2"},
      {:machete, ">= 0.0.0", only: [:test]}
    ]
  end
end
