defmodule <%= module %>.Mixfile do
  use Mix.Project

  def project do
    [app: :<%= app_name %>,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [
      applications: [:cowboy, :plug, :logger],
      mod: {<%= module %>, []}
    ]
  end
  
  defp deps do
    [
      {:cowboy, "~> 1.0"},
      {:plug, "~> 1.0"}
    ]
  end
end
