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

  def to_xy(%__MODULE__{repr: :off_board}) do
    :off_board
  end

  def to_xy(this) do
    x = Kernel.rem(this.repr, 8)
    y = Kernel.div(this.repr, 8)
    {x, y}
  end

  # maybe?
  #
  # defmacro stream(this, move_direction) do
  #   quote do
  #     Stream.iterate(unquote(this), fn position ->
  #       Chess.Position.unquote(move_direction)(position)
  #       # apply(__MODULE__, move_direction, [position])
  #     end)
  #     |> Stream.drop(1)
  #   end
  # end

  def stream(this, move_direction) do
    Stream.iterate(this, fn position ->
      apply(__MODULE__, move_direction, [position])
    end)
    |> Stream.drop(1)
  end

  def compose(moves) do
    fn starting_position ->
      Enum.reduce(moves, starting_position, fn move, position ->
        apply(__MODULE__, move, [position])
      end)
    end
  end

  def up(%__MODULE__{repr: :off_board} = this), do: this

  def up(this) do
    if this.repr + 8 > 63 do
      %{this | repr: :off_board}
    else
      %{this | repr: this.repr + 8}
    end
  end

  def down(%__MODULE__{repr: :off_board} = this), do: this

  def down(this) do
    if this.repr - 8 < 0 do
      %{this | repr: :off_board}
    else
      %{this | repr: this.repr - 8}
    end
  end

  def left(%__MODULE__{repr: :off_board} = this), do: this

  def left(this) do
    if crosses_row_boundary?(this.repr, this.repr - 1) || this.repr - 1 < 0 do
      %{this | repr: :off_board}
    else
      %{this | repr: this.repr - 1}
    end
  end

  def right(%__MODULE__{repr: :off_board} = this), do: this

  def right(this) do
    if crosses_row_boundary?(this.repr, this.repr + 1) || this.repr + 1 > 63 do
      %{this | repr: :off_board}
    else
      %{this | repr: this.repr + 1}
    end
  end

  def up_right(%__MODULE__{repr: :off_board} = this), do: this

  def up_right(this) do
    this |> up() |> right()
  end

  def up_left(%__MODULE__{repr: :off_board} = this), do: this

  def up_left(this) do
    this |> up() |> left()
  end

  def down_right(%__MODULE__{repr: :off_board} = this), do: this

  def down_right(this) do
    this |> down() |> right()
  end

  def down_left(%__MODULE__{repr: :off_board} = this), do: this

  def down_left(this) do
    this |> down() |> left()
  end

  defp crosses_row_boundary?(previous, next) do
    Kernel.div(previous, 8) != Kernel.div(next, 8)
  end
end
