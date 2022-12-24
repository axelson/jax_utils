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
      {:dotenv_parser, "~> 1.2"},
      {:jason, "~> 1.2"}
    ]
  end
end
