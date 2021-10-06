defmodule PiecesTest do
  use ExUnit.Case
  alias Chess.{Board, Position, Piece, Pieces}
  alias Chess.Pieces.{Pawn}

  describe "moves/2" do
    test "pawn free" do
      board = %Board{pieces: []}

      pawn_b = %Pawn{color: :black, position: Position.new(4, 6)}

      assert Piece.moves(pawn_b, board) |> Enum.map(&Position.to_xy(&1)) ==
               MapSet.new([{4, 5}, {3, 5}, {5, 5}]) |> MapSet.to_list()

      pawn_w = %Pawn{color: :white, position: Position.new(4, 6)}

      assert Piece.moves(pawn_w, board) |> Enum.map(&Position.to_xy(&1)) ==
               MapSet.new([{4, 7}, {3, 7}, {5, 7}]) |> MapSet.to_list()
    end

    test "pawn blocks" do
      board1 = %Board{
        pieces: [
          Pieces.new(Pawn, :black, Position.new(4, 5))
        ]
      }

      pawn_b = %Pawn{color: :black, position: Position.new(4, 6)}

      assert Piece.moves(pawn_b, board1) |> Enum.map(&Position.to_xy(&1)) ==
               MapSet.new([{3, 5}, {5, 5}]) |> MapSet.to_list()

      board2 = %Board{pieces: [Pieces.new(Pawn, :white, Position.new(5, 7))]}

      pawn_w = %Pawn{color: :white, position: Position.new(4, 6)}

      assert Piece.moves(pawn_w, board2) |> Enum.map(&Position.to_xy(&1)) ==
               MapSet.new([{4, 7}, {3, 7}]) |> MapSet.to_list()
    end

    test "pawn takes" do
      board1 = %Board{
        pieces: [
          Pieces.new(Pawn, :white, Position.new(4, 5))
        ]
      }

      pawn_b = %Pawn{color: :black, position: Position.new(4, 6)}

      assert Piece.moves(pawn_b, board1) |> Enum.map(&Position.to_xy(&1)) ==
               MapSet.new([{4, 5}, {3, 5}, {5, 5}]) |> MapSet.to_list()

      board2 = %Board{pieces: [Pieces.new(Pawn, :black, Position.new(5, 7))]}

      pawn_w = %Pawn{color: :white, position: Position.new(4, 6)}

      assert Piece.moves(pawn_w, board2) |> Enum.map(&Position.to_xy(&1)) ==
               MapSet.new([{4, 7}, {3, 7}, {5, 7}]) |> MapSet.to_list()
    end
  end
end
