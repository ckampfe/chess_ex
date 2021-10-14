defmodule PiecesTest do
  use ExUnit.Case
  alias Chess.{Board, Position, Piece, Pieces}
  alias Chess.Pieces.{Bishop, Pawn, King, Knight, Rook, Queen}

  describe "moves/2" do
    test "pawn free" do
      board = %Board{pieces: []}

      pawn_b = %Pawn{color: :black, position: Position.new(4, 6)}

      assert MapSet.equal?(
               Piece.moves(pawn_b, board) |> Enum.map(&Position.to_xy(&1)) |> MapSet.new(),
               MapSet.new([{4, 5}, {4, 4}])
             )

      pawn_w = %Pawn{color: :white, position: Position.new(4, 6)}

      assert MapSet.equal?(
               Piece.moves(pawn_w, board) |> Enum.map(&Position.to_xy(&1)) |> MapSet.new(),
               MapSet.new([{4, 7}])
             )
    end

    test "pawn blocks" do
      board1 = %Board{
        pieces: [
          Pieces.new(Pawn, :black, Position.new(4, 5))
        ]
      }

      pawn_b = %Pawn{color: :black, position: Position.new(4, 6)}

      assert MapSet.equal?(
               Piece.moves(pawn_b, board1) |> Enum.map(&Position.to_xy(&1)) |> MapSet.new(),
               MapSet.new([])
             )

      board2 = %Board{pieces: [Pieces.new(Pawn, :white, Position.new(5, 7))]}

      pawn_w = %Pawn{color: :white, position: Position.new(4, 6)}

      assert MapSet.equal?(
               Piece.moves(pawn_w, board2) |> Enum.map(&Position.to_xy(&1)) |> MapSet.new(),
               MapSet.new([{4, 7}])
             )

      board3 = %Board{pieces: [Pieces.new(Pawn, :white, Position.new(4, 3))]}

      pawn_w2 = %Pawn{color: :white, position: Position.new(4, 1)}

      assert MapSet.equal?(
               Piece.moves(pawn_w2, board3) |> Enum.map(&Position.to_xy(&1)) |> MapSet.new(),
               MapSet.new([{4, 2}])
             )
    end

    test "pawn takes" do
      board1 = %Board{
        pieces: [
          Pieces.new(Pawn, :white, Position.new(4, 5))
        ]
      }

      pawn_b = %Pawn{color: :black, position: Position.new(4, 6)}

      assert MapSet.equal?(
               Piece.moves(pawn_b, board1) |> Enum.map(&Position.to_xy(&1)) |> MapSet.new(),
               MapSet.new([])
             )

      board2 = %Board{pieces: [Pieces.new(Pawn, :black, Position.new(5, 7))]}

      pawn_w = %Pawn{color: :white, position: Position.new(4, 6)}

      assert MapSet.equal?(
               Piece.moves(pawn_w, board2) |> Enum.map(&Position.to_xy(&1)) |> MapSet.new(),
               MapSet.new([{4, 7}, {5, 7}])
             )
    end

    test "king free" do
      board1 = %Board{
        pieces: []
      }

      king_b = Pieces.new(King, :black, Position.new(4, 4))

      assert MapSet.equal?(
               Piece.moves(king_b, board1) |> Enum.map(&Position.to_xy(&1)) |> MapSet.new(),
               MapSet.new([
                 {4, 5},
                 {5, 5},
                 {5, 4},
                 {5, 3},
                 {4, 3},
                 {3, 3},
                 {3, 4},
                 {3, 5}
               ])
             )
    end

    test "king blocks" do
      board1 = %Board{
        pieces: [
          Pieces.new(Pawn, :black, Position.new(4, 5)),
          Pieces.new(Pawn, :black, Position.new(3, 3))
        ]
      }

      king_b = Pieces.new(King, :black, Position.new(4, 4))

      assert MapSet.equal?(
               Piece.moves(king_b, board1) |> Enum.map(&Position.to_xy(&1)) |> MapSet.new(),
               MapSet.new([
                 {5, 5},
                 {5, 4},
                 {5, 3},
                 {4, 3},
                 {3, 4},
                 {3, 5}
               ])
             )
    end

    test "king takes" do
      board1 = %Board{
        pieces: [
          Pieces.new(Pawn, :white, Position.new(4, 5)),
          Pieces.new(Pawn, :white, Position.new(3, 3))
        ]
      }

      king_b = Pieces.new(King, :black, Position.new(4, 4))

      assert MapSet.equal?(
               Piece.moves(king_b, board1) |> Enum.map(&Position.to_xy(&1)) |> MapSet.new(),
               MapSet.new([
                 {4, 5},
                 {5, 5},
                 {5, 4},
                 {5, 3},
                 {4, 3},
                 {3, 3},
                 {3, 4},
                 {3, 5}
               ])
             )
    end

    test "bishop free" do
      board1 = %Board{
        pieces: []
      }

      bishop_b = Pieces.new(Bishop, :black, Position.new(4, 4))

      assert Piece.moves(bishop_b, board1) |> Enum.map(&Position.to_xy(&1)) |> MapSet.new() ==
               MapSet.new([
                 {5, 5},
                 {6, 6},
                 {7, 7},
                 #
                 {5, 3},
                 {6, 2},
                 {7, 1},
                 #
                 {3, 3},
                 {2, 2},
                 {1, 1},
                 {0, 0},
                 #
                 {3, 5},
                 {2, 6},
                 {1, 7}
               ])
    end

    test "bishop blocks" do
      board1 = %Board{
        pieces: [
          Pieces.new(Pawn, :black, Position.new(1, 7)),
          Pieces.new(Pawn, :black, Position.new(6, 2))
        ]
      }

      bishop_b = Pieces.new(Bishop, :black, Position.new(4, 4))

      assert Piece.moves(bishop_b, board1) |> Enum.map(&Position.to_xy(&1)) |> MapSet.new() ==
               MapSet.new([
                 {5, 5},
                 {6, 6},
                 {7, 7},
                 #
                 {5, 3},
                 #
                 {3, 3},
                 {2, 2},
                 {1, 1},
                 {0, 0},
                 #
                 {3, 5},
                 {2, 6}
               ])
    end

    test "bishop takes" do
      board1 = %Board{
        pieces: [
          Pieces.new(Pawn, :white, Position.new(1, 7)),
          Pieces.new(Pawn, :white, Position.new(6, 2))
        ]
      }

      bishop_b = Pieces.new(Bishop, :black, Position.new(4, 4))

      assert Piece.moves(bishop_b, board1) |> Enum.map(&Position.to_xy(&1)) |> MapSet.new() ==
               MapSet.new([
                 {5, 5},
                 {6, 6},
                 {7, 7},
                 #
                 {5, 3},
                 {6, 2},
                 #
                 {3, 3},
                 {2, 2},
                 {1, 1},
                 {0, 0},
                 #
                 {3, 5},
                 {2, 6},
                 {1, 7}
               ])
    end

    test "knight free" do
      board1 = %Board{
        pieces: []
      }

      knight_b = Pieces.new(Knight, :black, Position.new(4, 4))

      assert Piece.moves(knight_b, board1) |> Enum.map(&Position.to_xy(&1)) |> MapSet.new() ==
               MapSet.new([
                 # up
                 {5, 6},
                 {3, 6},
                 # right
                 {6, 5},
                 {6, 3},
                 # down
                 {3, 2},
                 {5, 2},
                 # left
                 {2, 5},
                 {2, 3}
               ])
    end

    test "knight blocks" do
      board1 = %Board{
        pieces: [
          Pieces.new(Pawn, :black, Position.new(6, 5)),
          Pieces.new(Pawn, :black, Position.new(2, 3)),
          Pieces.new(Pawn, :white, Position.new(2, 5))
        ]
      }

      knight_b = Pieces.new(Knight, :black, Position.new(4, 4))

      assert Piece.moves(knight_b, board1) |> Enum.map(&Position.to_xy(&1)) |> MapSet.new() ==
               MapSet.new([
                 # up
                 {5, 6},
                 {3, 6},
                 # right
                 {6, 3},
                 # down
                 {3, 2},
                 {5, 2},
                 # left
                 {2, 5}
               ])
    end

    test "knight takes" do
      board1 = %Board{
        pieces: [
          Pieces.new(Pawn, :white, Position.new(6, 5)),
          Pieces.new(Pawn, :white, Position.new(2, 3)),
          Pieces.new(Pawn, :white, Position.new(2, 5))
        ]
      }

      knight_b = Pieces.new(Knight, :black, Position.new(4, 4))

      assert Piece.moves(knight_b, board1) |> Enum.map(&Position.to_xy(&1)) |> MapSet.new() ==
               MapSet.new([
                 # up
                 {5, 6},
                 {3, 6},
                 # right
                 {6, 5},
                 {6, 3},
                 # down
                 {3, 2},
                 {5, 2},
                 # left
                 {2, 5},
                 {2, 3}
               ])
    end

    test "rook free" do
      board1 = %Board{
        pieces: []
      }

      rook_b = Pieces.new(Rook, :black, Position.new(4, 4))

      assert Piece.moves(rook_b, board1) |> Enum.map(&Position.to_xy(&1)) |> MapSet.new() ==
               MapSet.new([
                 # up
                 {4, 5},
                 {4, 6},
                 {4, 7},
                 # right
                 {5, 4},
                 {6, 4},
                 {7, 4},
                 # down
                 {4, 3},
                 {4, 2},
                 {4, 1},
                 {4, 0},
                 # left
                 {3, 4},
                 {2, 4},
                 {1, 4},
                 {0, 4}
               ])
    end

    test "rook blocks" do
      board1 = %Board{
        pieces: [
          Pieces.new(Pawn, :black, Position.new(4, 5)),
          Pieces.new(Pawn, :black, Position.new(4, 3))
        ]
      }

      rook_b = Pieces.new(Rook, :black, Position.new(4, 4))

      assert Piece.moves(rook_b, board1) |> Enum.map(&Position.to_xy(&1)) |> MapSet.new() ==
               MapSet.new([
                 # up
                 # right
                 {5, 4},
                 {6, 4},
                 {7, 4},
                 # down
                 # left
                 {3, 4},
                 {2, 4},
                 {1, 4},
                 {0, 4}
               ])
    end

    test "rook takes" do
      board1 = %Board{
        pieces: [
          Pieces.new(Pawn, :black, Position.new(4, 5)),
          Pieces.new(Pawn, :black, Position.new(4, 3)),
          Pieces.new(Pawn, :white, Position.new(1, 4)),
          Pieces.new(Pawn, :white, Position.new(6, 4))
        ]
      }

      rook_b = Pieces.new(Rook, :black, Position.new(4, 4))

      assert Piece.moves(rook_b, board1) |> Enum.map(&Position.to_xy(&1)) |> MapSet.new() ==
               MapSet.new([
                 # up
                 # right
                 {5, 4},
                 {6, 4},
                 # down
                 # left
                 {3, 4},
                 {2, 4},
                 {1, 4}
               ])
    end

    test "queen free" do
      board1 = %Board{
        pieces: []
      }

      queen_b = Pieces.new(Queen, :black, Position.new(4, 4))

      assert Piece.moves(queen_b, board1) |> Enum.map(&Position.to_xy(&1)) |> MapSet.new() ==
               MapSet.new([
                 # up
                 {4, 5},
                 {4, 6},
                 {4, 7},
                 # right
                 {5, 4},
                 {6, 4},
                 {7, 4},
                 # down
                 {4, 3},
                 {4, 2},
                 {4, 1},
                 {4, 0},
                 # left
                 {3, 4},
                 {2, 4},
                 {1, 4},
                 {0, 4},
                 # up right
                 {5, 5},
                 {6, 6},
                 {7, 7},
                 # down right
                 {5, 3},
                 {6, 2},
                 {7, 1},
                 # down left
                 {3, 3},
                 {2, 2},
                 {1, 1},
                 {0, 0},
                 # up left
                 {3, 5},
                 {2, 6},
                 {1, 7}
               ])
    end

    test "queen blocks" do
      board1 = %Board{
        pieces: [
          Pieces.new(Pawn, :black, Position.new(4, 5))
        ]
      }

      queen_b = Pieces.new(Queen, :black, Position.new(4, 4))

      assert Piece.moves(queen_b, board1) |> Enum.map(&Position.to_xy(&1)) |> MapSet.new() ==
               MapSet.new([
                 # up
                 # right
                 {5, 4},
                 {6, 4},
                 {7, 4},
                 # down
                 {4, 3},
                 {4, 2},
                 {4, 1},
                 {4, 0},
                 # left
                 {3, 4},
                 {2, 4},
                 {1, 4},
                 {0, 4},
                 # up right
                 {5, 5},
                 {6, 6},
                 {7, 7},
                 # down right
                 {5, 3},
                 {6, 2},
                 {7, 1},
                 # down left
                 {3, 3},
                 {2, 2},
                 {1, 1},
                 {0, 0},
                 # up left
                 {3, 5},
                 {2, 6},
                 {1, 7}
               ])
    end

    test "queen takes" do
      board1 = %Board{
        pieces: [
          Pieces.new(Pawn, :black, Position.new(4, 5)),
          Pieces.new(Pawn, :white, Position.new(2, 2))
        ]
      }

      queen_b = Pieces.new(Queen, :black, Position.new(4, 4))

      assert Piece.moves(queen_b, board1) |> Enum.map(&Position.to_xy(&1)) |> MapSet.new() ==
               MapSet.new([
                 # up
                 # right
                 {5, 4},
                 {6, 4},
                 {7, 4},
                 # down
                 {4, 3},
                 {4, 2},
                 {4, 1},
                 {4, 0},
                 # left
                 {3, 4},
                 {2, 4},
                 {1, 4},
                 {0, 4},
                 # up right
                 {5, 5},
                 {6, 6},
                 {7, 7},
                 # down right
                 {5, 3},
                 {6, 2},
                 {7, 1},
                 # down left
                 {3, 3},
                 {2, 2},
                 # up left
                 {3, 5},
                 {2, 6},
                 {1, 7}
               ])
    end
  end
end
