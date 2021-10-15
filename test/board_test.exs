defmodule BoardTest do
  use ExUnit.Case
  alias Chess.Board

  test "to_string/1" do
    default_board =
      """
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
      """
      |> String.trim_trailing()

    assert Board.default() |> Board.to_string() == default_board
  end
end
