defmodule SetupTest do
  use ExUnit.Case

  alias Onirim.Core.Phases.Setup

  test "setup game - draw pile" do
    state = Setup.default_setup()

    assert state.draw_pile |> Enum.count() == 71
  end

  test "setup game - personal resources" do
    state = Setup.default_setup()

    assert state.personal_resources |> Enum.count() == 5
  end
end
