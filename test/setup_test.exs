defmodule SetupTest do
  use ExUnit.Case

  test "setup game - draw pile" do
    state = Phases.Setup.default_setup()

    assert state.draw_pile |> Enum.count() == 71
  end

  test "setup game - personal resources" do
    state = Phases.Setup.default_setup()

    assert state.personal_resources |> Enum.count() == 5
  end
end
