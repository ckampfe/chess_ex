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
    defstruct [:color, :position]
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

  # TODO: add check for ability for pawn to move double from the first row
  # TODO: add check for en passant
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

  def moves(this, board) do
    pieces_map =
      board.pieces
      |> Enum.map(fn piece ->
        {Chess.Piece.position(piece), piece}
      end)
      |> Enum.into(%{})

    Enum.flat_map([:up, :right, :down, :left], fn move_direction ->
      this.position
      |> Position.stream(move_direction)
      |> Enum.take_while(fn position ->
        Position.to_xy(position) != :off_board
      end)
      |> Enum.map(fn position ->
        {position, Map.get(pieces_map, position)}
      end)
      |> Enum.reduce_while([], fn {position, piece}, positions ->
        if piece do
          if Chess.Piece.color(piece) == this.color do
            {:halt, positions}
          else
            {:halt, [position | positions]}
          end
        else
          {:cont, [position | positions]}
        end
      end)
    end)
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

  def moves(this, board) do
    same_color_piece_positions =
      board.pieces
      |> Enum.filter(fn piece ->
        Chess.Piece.color(piece) == color(this)
      end)
      |> Enum.map(&position(&1))
      |> Enum.into(MapSet.new())

    [
      Position.compose([:up, :up, :right]),
      Position.compose([:up, :up, :left]),
      Position.compose([:right, :right, :up]),
      Position.compose([:right, :right, :down]),
      Position.compose([:down, :down, :right]),
      Position.compose([:down, :down, :left]),
      Position.compose([:left, :left, :down]),
      Position.compose([:left, :left, :up])
    ]
    |> Stream.map(fn move ->
      move.(this.position)
    end)
    |> Stream.filter(fn position ->
      Position.to_xy(position) != :off_board
    end)
    |> Stream.reject(fn position ->
      MapSet.member?(same_color_piece_positions, position)
    end)
    |> Enum.to_list()
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

  def moves(this, board) do
    pieces_map =
      board.pieces
      |> Enum.map(fn piece ->
        {Chess.Piece.position(piece), piece}
      end)
      |> Enum.into(%{})

    Enum.flat_map([:up_left, :up_right, :down_right, :down_left], fn move_direction ->
      this.position
      |> Position.stream(move_direction)
      |> Enum.take_while(fn position ->
        Position.to_xy(position) != :off_board
      end)
      |> Enum.map(fn position ->
        {position, Map.get(pieces_map, position)}
      end)
      |> Enum.reduce_while([], fn {position, piece}, positions ->
        if piece do
          if Chess.Piece.color(piece) == this.color do
            {:halt, positions}
          else
            {:halt, [position | positions]}
          end
        else
          {:cont, [position | positions]}
        end
      end)
    end)
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

  def moves(this, board) do
    pieces_map =
      board.pieces
      |> Enum.map(fn piece ->
        {Chess.Piece.position(piece), piece}
      end)
      |> Enum.into(%{})

    Enum.flat_map(
      [:up, :right, :down, :left, :up_left, :up_right, :down_right, :down_left],
      fn move_direction ->
        this.position
        |> Position.stream(move_direction)
        |> Enum.take_while(fn position ->
          Position.to_xy(position) != :off_board
        end)
        |> Enum.map(fn position ->
          {position, Map.get(pieces_map, position)}
        end)
        |> Enum.reduce_while([], fn {position, piece}, positions ->
          if piece do
            if Chess.Piece.color(piece) == this.color do
              {:halt, positions}
            else
              {:halt, [position | positions]}
            end
          else
            {:cont, [position | positions]}
          end
        end)
      end
    )
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

  # TODO: add check for moving into check
  def moves(this, board) do
    [
      Position.up(this.position),
      Position.up_right(this.position),
      Position.right(this.position),
      Position.down_right(this.position),
      Position.down(this.position),
      Position.down_left(this.position),
      Position.left(this.position),
      Position.up_left(this.position)
    ]
    |> Enum.reject(fn position -> Position.to_xy(position) == :off_board end)
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
      :black -> "\u265A"
      :white -> "\u2654"
    end
  end
end
