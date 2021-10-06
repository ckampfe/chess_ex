defmodule Chess.Position do
  # repr is an integer
  defstruct [:repr]

  # def new(column, row) when is_list(column) do
  #   x =
  #     case column do
  #       'a' -> 0
  #       'b' -> 1
  #       'c' -> 2
  #       'd' -> 3
  #       'e' -> 4
  #       'f' -> 5
  #       'g' -> 6
  #       'h' -> 7
  #     end

  #   y = row

  #   new(x, y)
  # end

  def new(x, y) when x >= 0 and x < 8 and y >= 0 and y < 8 do
    n = y * 8 + x

    %__MODULE__{
      repr: n
    }
  end

  def to_xy(this) do
    x = :erlang.rem(this.repr, 8)
    y = :erlang.div(this.repr, 8)
    {x, y}
  end

  def up(this) do
    %{this | repr: this.repr + 8}
  end

  def down(this) do
    %{this | repr: this.repr - 8}
  end

  def left(this) do
    %{this | repr: this.repr - 1}
  end

  def right(this) do
    %{this | repr: this.repr + 1}
  end

  def up_right(this) do
    this |> up() |> right()
  end

  def up_left(this) do
    this |> up() |> left()
  end

  def down_right(this) do
    this |> down() |> right()
  end

  def down_left(this) do
    this |> down() |> left()
  end
end
