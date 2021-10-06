defmodule PositionTest do
  use ExUnit.Case
  alias Chess.Position

  test "position new/2, to_xy/1" do
    for x <- 0..7 do
      for y <- 0..7 do
        pos = Position.new(x, y)
        assert Position.to_xy(pos) == {x, y}
      end
    end
  end

  test "position up/1" do
    assert Position.new(4, 0) |> Position.up() |> Position.to_xy() == {4, 1}
  end

  test "position down/1" do
    assert Position.new(4, 4) |> Position.down() |> Position.to_xy() == {4, 3}
  end

  test "position left/1" do
    assert Position.new(4, 4) |> Position.left() |> Position.to_xy() == {3, 4}
  end

  test "position right/1" do
    assert Position.new(4, 4) |> Position.right() |> Position.to_xy() == {5, 4}
  end
end
