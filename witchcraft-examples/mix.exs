defmodule WitchcraftExamples.MixProject do
  use Mix.Project

  def project do
    [
      app: :witchcraft_examples,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:algae, git: "https://github.com/witchcrafters/algae.git", override: true},
      {:quark, git: "https://github.com/witchcrafters/quark.git", override: true},
      {:type_class, git: "https://github.com/witchcrafters/type_class.git", override: true},
      # Maintain until PR is merged. (https://github.com/witchcrafters/witchcraft/pull/83)
      {:witchcraft, git: "https://github.com/witchcrafters/witchcraft.git", override: true},
      {:reather, git: "https://github.com/jechol/reather.git"}
    ]
  end
end
