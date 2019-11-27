defmodule Categories.MixProject do
  use Mix.Project

  def project,
    do: [
      app: :extdata,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]

  def application,
    do: [
      extra_applications: [:logger]
    ]

  defp deps,
    do: [
      jason: "~> 1.1"
    ]
end
