# Chess

[![Elixir CI](https://github.com/ckampfe/chess/actions/workflows/elixir.yml/badge.svg)](https://github.com/ckampfe/chess/actions/workflows/elixir.yml)

```
iex(65)> Chess.Board.default() |> Chess.Board.to_string() |> IO.puts
┌───────────────────────────────┐
│ ♜ │ ♞ │ ♝ │ ♛ │ ♚ │ ♝ │ ♞ │ ♜ │
│ ♟ │ ♟ │ ♟ │ ♟ │ ♟ │ ♟ │ ♟ │ ♟ │
│   │ ▀ │   │ ▀ │   │ ▀ │   │ ▀ │
│ ▀ │   │ ▀ │   │ ▀ │   │ ▀ │   │
│   │ ▀ │   │ ▀ │   │ ▀ │   │ ▀ │
│ ▀ │   │ ▀ │   │ ▀ │   │ ▀ │   │
│ ♙ │ ♙ │ ♙ │ ♙ │ ♙ │ ♙ │ ♙ │ ♙ │
│ ♖ │ ♘ │ ♗ │ ♕ │ ♔ │ ♗ │ ♘ │ ♖ │
└───────────────────────────────┘
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `chess` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:chess, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/chess](https://hexdocs.pm/chess).
