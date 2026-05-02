# CPFHub: Elixir SDK for CPFHub.io

🇺🇸 **English** | [🇧🇷 Português](#português)

**Official Elixir SDK for [CPFHub.io](https://cpfhub.io) — Brazilian CPF Lookup API**

[![Hex.pm](https://img.shields.io/hexpm/v/cpfhub)](https://hex.pm/packages/cpfhub)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

---

## What is CPFHub.io?

CPFHub.io is a REST API that returns name, gender, and date of birth from any Brazilian CPF number — in ~300ms, with 99.9% uptime and full LGPD compliance.

**10M+ CPFs queried · 1,300+ active companies · 99.9% uptime**

---

## Installation

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

## curl Example

```bash
curl -X GET "https://api.cpfhub.io/cpf/12345678909" \
  -H "x-api-key: YOUR_API_KEY"
```

**Response:**

```json
{
  "success": true,
  "data": {
    "cpf": "12345678909",
    "name": "Fulano de Tal",
    "nameUpper": "FULANO DE TAL",
    "gender": "M",
    "birthDate": "15/06/1990",
    "day": 15,
    "month": 6,
    "year": 1990
  }
}
```

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

### `CPFHub.lookup(cpf, opts \\ [])`

Looks up a CPF and returns the associated identity data.

Accepts CPF with or without formatting (`000.000.000-00` or `00000000000`).

**Returns:** `{:ok, %CPFHub.Result{}}` or `{:error, reason}`

#### `CPFHub.Result` fields

| Field | Type | Description |
|-------|------|-------------|
| `cpf` | `String.t()` | CPF number (digits only) |
| `name` | `String.t()` | Full name |
| `name_upper` | `String.t()` | Full name in uppercase |
| `gender` | `String.t()` | `"M"` or `"F"` |
| `birth_date` | `String.t()` | Date of birth — `"DD/MM/YYYY"` |
| `day` | `integer()` | Birth day |
| `month` | `integer()` | Birth month |
| `year` | `integer()` | Birth year |

---

## Error Handling

```elixir
case CPFHub.lookup("00000000000") do
  {:ok, result} ->
    IO.puts("Name: #{result.name}")

  {:error, :invalid_cpf} ->
    IO.puts("Invalid CPF format")  # 400

  {:error, :unauthorized} ->
    IO.puts("Invalid or missing API key")  # 401

  {:error, :not_found} ->
    IO.puts("CPF not found")  # 404

  {:error, :rate_limit_exceeded} ->
    IO.puts("Rate limit exceeded")  # 429

  {:error, reason} ->
    IO.puts("Error: #{inspect(reason)}")
end
```

---

## Examples

### Phoenix Controller

```elixir
defmodule MyAppWeb.OnboardingController do
  use MyAppWeb, :controller

  def verify(conn, %{"cpf" => cpf}) do
    case CPFHub.lookup(cpf) do
      {:ok, result} ->
        json(conn, %{name: result.name, gender: result.gender})

      {:error, :not_found} ->
        conn |> put_status(404) |> json(%{error: "CPF not found"})

      {:error, reason} ->
        conn |> put_status(500) |> json(%{error: inspect(reason)})
    end
  end
end
```

### Real-world onboarding

```elixir
def onboard_user(cpf, email) do
  with {:ok, identity} <- CPFHub.lookup(cpf),
       {:ok, user} <- Accounts.create_user(%{
         cpf: cpf,
         name: identity.name,
         email: email,
         birth_year: identity.year
       }) do
    {:ok, user}
  end
end
```

---

## Rate Limits

| Plan | Limit |
|------|-------|
| Free | 1 request every 2 seconds · 50 requests/month |
| Pro | 1 request per second · 1,000 requests/month |
| Corporate | Custom |

---

## Plans & Pricing

| Plan | Price | Included | Extra |
|------|-------|----------|-------|
| **Free** | R$ 0/month | 50 lookups | — |
| **Pro** | R$ 149/month | 1,000 lookups | R$ 0,15/lookup |
| **Corporate** | Custom | Custom | Custom |

[View full pricing at cpfhub.io →](https://cpfhub.io#pricing)

---

## Requirements

- Elixir 1.14+
- Erlang/OTP 25+

---

## Links

- [Documentation](https://cpfhub.io/documentacao)
- [Hex.pm Package](https://hex.pm/packages/cpfhub)
- [Dashboard](https://app.cpfhub.io)
- [Status Page](https://app.cpfhub.io/status)
- [Pricing](https://cpfhub.io#pricing)
- [LGPD Compliance](https://cpfhub.io/lgpd)
- [OpenAPI Specification](https://github.com/cpfhub/cpfhub-openapi/blob/main/openapi.yaml)
- [MCP Server (AI Agents)](https://github.com/cpfhub/cpfhub-mcp)

---

## License

MIT © [CPFHub.io](https://cpfhub.io)

---

# Português

[🇺🇸 English](#cpfhub-elixir-sdk-for-cpfhubio) | 🇧🇷 **Português**

**SDK Elixir oficial para [CPFHub.io](https://cpfhub.io) — API de Consulta de CPF Brasileiro**

---

## O que é o CPFHub.io?

O CPFHub.io é uma API REST que retorna nome, gênero e data de nascimento de qualquer CPF brasileiro — em ~300ms, com 99,9% de uptime e total conformidade com a LGPD.

**10M+ CPFs consultados · 1.300+ empresas ativas · 99,9% uptime**

---

## Instalação

```elixir
# mix.exs
def deps do
  [
    {:cpfhub, "~> 1.0"}
  ]
end
```

---

## Início Rápido

```elixir
{:ok, result} = CPFHub.lookup("00000000000", api_key: System.get_env("CPFHUB_API_KEY"))

IO.puts(result.name)       # "Fulano de Tal"
IO.puts(result.gender)     # "M"
IO.puts(result.birth_date) # "15/06/1990"
```

Obtenha sua chave de API gratuita em [app.cpfhub.io](https://app.cpfhub.io) — sem cartão de crédito.

---

## Exemplo curl

```bash
curl -X GET "https://api.cpfhub.io/cpf/12345678909" \
  -H "x-api-key: SUA_CHAVE_DE_API"
```

**Resposta:**

```json
{
  "success": true,
  "data": {
    "cpf": "12345678909",
    "name": "Fulano de Tal",
    "nameUpper": "FULANO DE TAL",
    "gender": "M",
    "birthDate": "15/06/1990",
    "day": 15,
    "month": 6,
    "year": 1990
  }
}
```

---

## Configuração

```elixir
# config/config.exs
config :cpfhub,
  api_key: System.get_env("CPFHUB_API_KEY"),
  timeout: 10_000
```

Depois use sem passar a chave:

```elixir
{:ok, result} = CPFHub.lookup("00000000000")
```

---

## Referência da API

### `CPFHub.lookup(cpf, opts \\ [])`

Consulta um CPF e retorna os dados de identidade associados.

Aceita CPF com ou sem formatação (`000.000.000-00` ou `00000000000`).

**Retorna:** `{:ok, %CPFHub.Result{}}` ou `{:error, reason}`

#### Campos de `CPFHub.Result`

| Campo | Tipo | Descrição |
|-------|------|-----------|
| `cpf` | `String.t()` | CPF (apenas dígitos) |
| `name` | `String.t()` | Nome completo |
| `name_upper` | `String.t()` | Nome completo em maiúsculas |
| `gender` | `String.t()` | `"M"` ou `"F"` |
| `birth_date` | `String.t()` | Data de nascimento — `"DD/MM/YYYY"` |
| `day` | `integer()` | Dia de nascimento |
| `month` | `integer()` | Mês de nascimento |
| `year` | `integer()` | Ano de nascimento |

---

## Tratamento de Erros

```elixir
case CPFHub.lookup("00000000000") do
  {:ok, result} ->
    IO.puts("Nome: #{result.name}")

  {:error, :invalid_cpf} ->
    IO.puts("Formato de CPF inválido")  # 400

  {:error, :unauthorized} ->
    IO.puts("Chave de API inválida ou ausente")  # 401

  {:error, :not_found} ->
    IO.puts("CPF não encontrado")  # 404

  {:error, :rate_limit_exceeded} ->
    IO.puts("Limite de requisições excedido")  # 429

  {:error, reason} ->
    IO.puts("Erro: #{inspect(reason)}")
end
```

---

## Exemplos

### Phoenix Controller

```elixir
defmodule MyAppWeb.OnboardingController do
  use MyAppWeb, :controller

  def verify(conn, %{"cpf" => cpf}) do
    case CPFHub.lookup(cpf) do
      {:ok, result} ->
        json(conn, %{name: result.name, gender: result.gender})

      {:error, :not_found} ->
        conn |> put_status(404) |> json(%{error: "CPF não encontrado"})

      {:error, reason} ->
        conn |> put_status(500) |> json(%{error: inspect(reason)})
    end
  end
end
```

### Onboarding real

```elixir
def onboard_user(cpf, email) do
  with {:ok, identity} <- CPFHub.lookup(cpf),
       {:ok, user} <- Accounts.create_user(%{
         cpf: cpf,
         name: identity.name,
         email: email,
         birth_year: identity.year
       }) do
    {:ok, user}
  end
end
```

---

## Limites de Requisição

| Plano | Limite |
|-------|--------|
| Gratuito | 1 requisição a cada 2 segundos · 50 requisições/mês |
| Pro | 1 requisição por segundo · 1.000 requisições/mês |
| Corporativo | Personalizado |

---

## Planos e Preços

| Plano | Preço | Incluído | Extra |
|-------|-------|----------|-------|
| **Gratuito** | R$ 0/mês | 50 consultas | — |
| **Pro** | R$ 149/mês | 1.000 consultas | R$ 0,15/consulta |
| **Corporativo** | Personalizado | Personalizado | Personalizado |

[Ver preços completos em cpfhub.io →](https://cpfhub.io#pricing)

---

## Requisitos

- Elixir 1.14+
- Erlang/OTP 25+

---

## Links

- [Documentação](https://cpfhub.io/documentacao)
- [Pacote Hex.pm](https://hex.pm/packages/cpfhub)
- [Dashboard](https://app.cpfhub.io)
- [Página de Status](https://app.cpfhub.io/status)
- [Preços](https://cpfhub.io#pricing)
- [Conformidade LGPD](https://cpfhub.io/lgpd)
- [Especificação OpenAPI](https://github.com/cpfhub/cpfhub-openapi/blob/main/openapi.yaml)
- [Servidor MCP (Agentes de IA)](https://github.com/cpfhub/cpfhub-mcp)

---

## Licença

MIT © [CPFHub.io](https://cpfhub.io)
