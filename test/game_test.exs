defmodule GameTest do
  use ExUnit.Case

  test "setup game" do
    assert Game.setup().draw_pile.cards |> Enum.count() == 76
  end

  test "resolve limbo" do
    Game.setup()
    |> Game.resolve_limbo()

    assert true
  end
end
