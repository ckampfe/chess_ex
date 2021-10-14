defmodule Chess.Game do
  defstruct [:board, :moves, :to_move]

  alias Chess.{Board, Piece}

  def new() do
    new(Board.default(), :white)
  end

  def new(board, to_move) do
    %__MODULE__{
      board: board,
      moves: [],
      to_move: to_move
    }
  end

  def move(this, starting_position, ending_position) do
    piece_at_position =
      this.board.pieces
      |> Enum.find(fn piece ->
        Piece.position(piece) == starting_position
      end)

    pieces =
      this.board.pieces
      |> Enum.reject(fn piece ->
        piece_position = Chess.Piece.position(piece)
        piece_position == starting_position || piece_position == ending_position
      end)

    piece_at_position = %{piece_at_position | position: ending_position}

    board = %{this.board | pieces: [piece_at_position | pieces]}

    # TODO
    # assert move is valid
    # record move
    # alternate to_move
    %{
      this
      | to_move: if(this.to_move == :white, do: :black, else: :white),
        moves: [{this.to_move, starting_position, ending_position} | this.moves],
        board: board
    }
  end
end
