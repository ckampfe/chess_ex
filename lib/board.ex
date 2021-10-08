defmodule Chess.Board do
  defstruct [:pieces]

  def default() do
    %__MODULE__{
      pieces:
        Enum.flat_map(%{white: 1, black: 6}, fn {color, y} ->
          Enum.map(0..7, fn x ->
            Chess.Pieces.new(
              Chess.Pieces.Pawn,
              color,
              Chess.Position.new(x, y)
            )
          end)
        end) ++
          Enum.flat_map(%{white: 0, black: 7}, fn {color, y} ->
            [
              Chess.Pieces.new(
                Chess.Pieces.Rook,
                color,
                Chess.Position.new(0, y)
              ),
              Chess.Pieces.new(
                Chess.Pieces.Rook,
                color,
                Chess.Position.new(7, y)
              ),
              Chess.Pieces.new(
                Chess.Pieces.Knight,
                color,
                Chess.Position.new(1, y)
              ),
              Chess.Pieces.new(
                Chess.Pieces.Knight,
                color,
                Chess.Position.new(6, y)
              ),
              Chess.Pieces.new(
                Chess.Pieces.Bishop,
                color,
                Chess.Position.new(2, y)
              ),
              Chess.Pieces.new(
                Chess.Pieces.Bishop,
                color,
                Chess.Position.new(5, y)
              ),
              Chess.Pieces.new(
                Chess.Pieces.Queen,
                color,
                Chess.Position.new(3, y)
              ),
              Chess.Pieces.new(
                Chess.Pieces.King,
                color,
                Chess.Position.new(4, y)
              )
            ]
          end)
    }
  end

  def to_string(this) do
    horizontal_bar = "\u2500"
    three_horizontal_bars = "#{horizontal_bar}#{horizontal_bar}#{horizontal_bar}"
    top_left_corner = "\u250C"
    top_right_corner = "\u2510"
    bottom_left_corner = "\u2514"
    bottom_right_corner = "\u2518"
    dark_box = "\u2580"
    space = " "
    vertical_bar = "\u2502"

    indexed =
      this.pieces
      |> Enum.map(fn piece ->
        xy = Chess.Position.to_xy(piece.position)
        {xy, piece}
      end)
      |> Enum.into(%{})

    top_row =
      top_left_corner <>
        (Enum.map(0..7, fn _ -> three_horizontal_bars end) |> Enum.join(horizontal_bar)) <>
        top_right_corner

    bottom_row =
      bottom_left_corner <>
        (Enum.map(0..7, fn _ -> three_horizontal_bars end) |> Enum.join(horizontal_bar)) <>
        bottom_right_corner

    piece_rows =
      for y <- 7..0 do
        row =
          for x <- 7..0 do
            case Map.fetch(indexed, {x, y}) do
              {:ok, piece} ->
                Chess.Piece.to_string(piece)

              :error ->
                if :erlang.rem(x + y, 2) != 0 do
                  dark_box
                else
                  space
                end
            end
          end

        ["#{vertical_bar} ", Enum.join(row, " #{vertical_bar} "), " #{vertical_bar}"]
      end

    ([top_row | piece_rows] ++ [bottom_row])
    |> Enum.join("\n")
  end
end
