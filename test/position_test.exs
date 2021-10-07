defmodule PositionTest do
  use ExUnit.Case
  alias Chess.Position
  require Chess.Position

  test "new/2, to_xy/1" do
    for x <- 0..7 do
      for y <- 0..7 do
        pos = Position.new(x, y)
        assert Position.to_xy(pos) == {x, y}
      end
    end
  end

  test "up/1" do
    assert Position.new(4, 0) |> Position.up() |> Position.to_xy() == {4, 1}

    for x <- 0..7 do
      assert Position.new(x, 7) |> Position.up() |> Position.to_xy() == :off_board
    end
  end

  test "down/1" do
    assert Position.new(4, 4) |> Position.down() |> Position.to_xy() == {4, 3}

    for x <- 0..7 do
      assert Position.new(x, 0) |> Position.down() |> Position.to_xy() == :off_board
    end
  end

  test "left/1" do
    assert Position.new(4, 4) |> Position.left() |> Position.to_xy() == {3, 4}

    for y <- 0..7 do
      assert Position.new(0, y) |> Position.left() |> Position.to_xy() == :off_board
    end
  end

  test "right/1" do
    assert Position.new(4, 4) |> Position.right() |> Position.to_xy() == {5, 4}

    for y <- 0..7 do
      assert Position.new(7, y) |> Position.right() |> Position.to_xy() == :off_board
    end
  end

  test "stream/2" do
    expected =
      for y <- 1..7 do
        {4, y}
      end

    assert Position.new(4, 0)
           |> Position.stream(:up)
           |> Enum.take_while(fn position ->
             Position.to_xy(position) != :off_board
           end)
           |> Enum.map(&Position.to_xy(&1)) == expected

    expected =
      for x <- 4..7 do
        {x, x}
      end

    assert Position.new(3, 3)
           |> Position.stream(:up_right)
           |> Enum.take_while(fn position ->
             Position.to_xy(position) != :off_board
           end)
           |> Enum.map(&Position.to_xy(&1)) == expected
  end
end
