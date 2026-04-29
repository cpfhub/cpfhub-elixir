defmodule CPFHub.MixProject do
  use Mix.Project

  @version "1.0.0"
  @source_url "https://github.com/cpfhub/cpfhub-elixir"

  def project do
    [
      app: :cpfhub,
      version: @version,
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      name: "CPFHub",
      source_url: @source_url,
      homepage_url: "https://cpfhub.io",
      docs: [
        main: "CPFHub",
        extras: ["README.md"]
      ]
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:req, "~> 0.4"},
      {:jason, "~> 1.4"},
      {:ex_doc, "~> 0.30", only: :dev, runtime: false}
    ]
  end

  defp description do
    "Official Elixir SDK for CPFHub.io — Brazilian CPF lookup API. " <>
      "Get name, gender and date of birth from any CPF in ~300ms."
  end

  defp package do
    [
      name: "cpfhub",
      licenses: ["MIT"],
      links: %{
        "Homepage" => "https://cpfhub.io",
        "Documentation" => "https://cpfhub.io/documentacao",
        "GitHub" => @source_url
      },
      maintainers: ["CPFHub.io"],
      keywords: [
        "cpf", "cpf-api", "cpf-lookup", "cpf-validation", "cpfhub",
        "brazil", "brasil", "fintech", "kyc", "identity", "lgpd"
      ]
    ]
  end
end
