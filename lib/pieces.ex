defprotocol Chess.Piece do
  def position(piece)
  def color(piece)
  def moves(piece, board)
  def to_string(piece)
end

defmodule Chess.Pieces do
  def new(piece_kind, color, position) do
    struct(piece_kind, color: color, position: position)
  end

  defmodule Pawn do
    defstruct [:color, :position]
  end

  defmodule Rook do
    defstruct [:position, :color]
  end

  defmodule Knight do
    defstruct [:color, :position]
  end

  defmodule Bishop do
    defstruct [:color, :position]
  end

  defmodule Queen do
    defstruct [:color, :position]
  end

  defmodule King do
    defstruct [:color, :position]
  end
end

defimpl Chess.Piece, for: Chess.Pieces.Pawn do
  alias Chess.Position

  def color(this) do
    this.color
  end

  def position(this) do
    this.position
  end

  def moves(this, board) do
    case color(this) do
      :black ->
        [
          Position.down(this.position),
          Position.down_left(this.position),
          Position.down_right(this.position)
        ]

      :white ->
        [
          Position.up(this.position),
          Position.up_left(this.position),
          Position.up_right(this.position)
        ]
    end
    |> Enum.filter(fn move ->
      same_color_piece_positions =
        board.pieces
        |> Enum.filter(fn piece ->
          piece.color == color(this)
        end)
        |> Enum.map(&position(&1))
        |> Enum.into(MapSet.new())

      !MapSet.member?(same_color_piece_positions, move)
    end)
    |> Enum.into(MapSet.new())
  end

  def to_string(this) do
    case this.color do
      :black -> "\u265F"
      :white -> "\u2659"
    end
  end
end

defimpl Chess.Piece, for: Chess.Pieces.Rook do
  alias Chess.Position

  def color(this) do
    this.color
  end

  def position(this) do
    this.position
  end

  def to_string(this) do
    case this.color do
      :black -> "\u265C"
      :white -> "\u2656"
    end
  end
end

defimpl Chess.Piece, for: Chess.Pieces.Knight do
  alias Chess.Position

  def color(this) do
    this.color
  end

  def position(this) do
    this.position
  end

  def to_string(this) do
    case color(this) do
      :black -> "\u265E"
      :white -> "\u2658"
    end
  end
end

defimpl Chess.Piece, for: Chess.Pieces.Bishop do
  alias Chess.Position

  def color(this) do
    this.color
  end

  def position(this) do
    this.position
  end

  def to_string(this) do
    case this.color do
      :black -> "\u265D"
      :white -> "\u2657"
    end
  end
end

defimpl Chess.Piece, for: Chess.Pieces.Queen do
  alias Chess.Position

  def color(this) do
    this.color
  end

  def position(this) do
    this.position
  end

  def to_string(this) do
    case this.color do
      :black -> "\u265B"
      :white -> "\u2655"
    end
  end
end

defimpl Chess.Piece, for: Chess.Pieces.King do
  alias Chess.Position

  def color(this) do
    this.color
  end

  def position(this) do
    this.position
  end

  def to_string(this) do
    case this.color do
      :black -> "\u265A"
      :white -> "\u2654"
    end
  end
end
