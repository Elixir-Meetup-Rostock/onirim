defmodule SetupTest do
  use ExUnit.Case

  test "setup game" do
    assert Phases.Setup.default_setup().draw_pile |> Enum.count() == 76
  end
end
