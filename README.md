# CPFHub: SDK Elixir para Consulta de CPF (AI-Native)

**Official Elixir SDK for [CPFHub.io](https://cpfhub.io) — Brazilian CPF Lookup API**

> SDK oficial Elixir para a [CPFHub.io](https://cpfhub.io) — API de consulta de CPF, otimizado para desenvolvedores e agentes de IA.

[![Hex.pm](https://img.shields.io/hexpm/v/cpfhub)](https://hex.pm/packages/cpfhub)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

---

## O que é CPFHub.io?

CPFHub.io é uma API REST que retorna nome, gênero e data de nascimento a partir de qualquer CPF brasileiro — em ~300ms, com 99.9% de uptime, e total conformidade com a LGPD.

**10M+ CPFs consultados · 1.300+ empresas ativas · 99.9% uptime**

---

## Por que usar o SDK Elixir do CPFHub.io?

Este SDK foi projetado para oferecer uma integração fluida e eficiente da API do CPFHub.io em projetos Elixir, com foco em Developer Experience (DX) e compatibilidade com Agentes de IA.

### 1. Developer Experience (DX) Otimizada

*   **Integração Rápida**: Facilita a incorporação de consultas de CPF em seus aplicativos e sistemas Elixir.
*   **Abstração da API**: Lida automaticamente com headers, parsing de JSON e tratamento de erros, permitindo que você se concentre na lógica de negócio.

### 2. Compatibilidade Nativa com Agentes de IA

Para facilitar a integração com agentes de IA e LLMs, este SDK e a API do CPFHub.io oferecem:

*   **OpenAPI Specification**: Um arquivo `openapi.yaml` está disponível para descrever a API, permitindo que agentes entendam automaticamente sua estrutura e schemas tipados.
*   **Tool Descriptions**: A API é facilmente representável como "tool descriptions" para LLMs, facilitando a invocação em frameworks de agentes.
*   **MCP Server Nativo**: O CPFHub.io oferece um servidor MCP que expõe a API diretamente para agentes de IA (Claude, Cursor, Windsurf), complementando o uso em ambientes de desenvolvimento Elixir.

---

## Installation / Instalação

```elixir
# mix.exs
def deps do
  [
    {:cpfhub, "~> 1.0"}
  ]
end
```

---

## Quick Start

```elixir
{:ok, result} = CPFHub.lookup("00000000000", api_key: System.get_env("CPFHUB_API_KEY"))

IO.puts(result.name)       # "Fulano de Tal"
IO.puts(result.gender)     # "M"
IO.puts(result.birth_date) # "15/06/1990"
```

Get your free API key at [app.cpfhub.io](https://app.cpfhub.io) — no credit card required.

---

## Configuration

```elixir
# config/config.exs
config :cpfhub,
  api_key: System.get_env("CPFHUB_API_KEY"),
  timeout: 10_000
```

Then use without passing the key:

```elixir
{:ok, result} = CPFHub.lookup("00000000000")
```

---

## API Reference

### `CPFHub.lookup(cpf, opts \\ []) :: {:ok, CPFHub.Result.t()} | {:error, CPFHub.Error.t()}`

| Option | Default | Description |
|--------|---------|-------------|
| `api_key` | config value | CPFHub API key |
| `timeout` | `10_000` | Timeout in ms |

#### `CPFHub.Result` struct

```elixir
%CPFHub.Result{
  cpf: "00000000000",
  name: "Fulano de Tal",
  name_upper: "FULANO DE TAL",
  gender: "M",
  birth_date: "15/06/1990",
  day: 15,
  month: 6,
  year: 1990
}
```

---

## Error Handling

```elixir
case CPFHub.lookup("00000000000") do
  {:ok, result} ->
    IO.puts("Name: #{result.name}")

  {:error, %CPFHub.Error{status: 400}} ->
    IO.puts("Invalid CPF format")

  {:error, %CPFHub.Error{status: 429}} ->
    IO.puts("Rate limit exceeded — try again shortly")

  {:error, error} ->
    IO.puts("Error: #{error.message}")
end
```

---

## Phoenix Example

```elixir
# lib/my_app_web/controllers/onboarding_controller.ex
defmodule MyAppWeb.OnboardingController do
  use MyAppWeb, :controller

  def verify(conn, %{"cpf" => cpf}) do
    case CPFHub.lookup(cpf) do
      {:ok, result} ->
        json(conn, %{name: result.name, gender: result.gender})

      {:error, error} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{error: error.message})
    end
  end
end
```

---

## Rate Limits / Limites

| Plan | Limit |
|------|-------|
| Free | 1 req/2s · 50/month |
| Pro | 1 req/s · 1,000/month |
| Corporate | Custom |

---

## Requirements / Requisitos

- Elixir 1.14+
- Erlang/OTP 25+

---

## Links

- [Documentation / Documentação](https://cpfhub.io/documentacao)
- [HexDocs](https://hexdocs.pm/cpfhub)
- [Dashboard / Painel](https://app.cpfhub.io)
- [Status Page](https://app.cpfhub.io/status)
- [LGPD Compliance](https://cpfhub.io/lgpd)
- [OpenAPI Specification](openapi.yaml)

---

## License / Licença

MIT © [CPFHub.io](https://cpfhub.io)
