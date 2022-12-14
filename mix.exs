defmodule PhoenixSelect2.MixProject do
  use Mix.Project

  def project do
    [
      app: :phoenix_select2,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package()
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
      {:phoenix_live_view, "~> 0.15.0"}
    ]
  end

  defp package do
    [
      description: "Improved multiselect live view experience",
      licenses: ["MIT"],
      maintainers: ["Almir Neto"],
      links: %{
        "GitHub" => "https://github.com/netond/phoenix_select2"
      }
    ]
  end
end
