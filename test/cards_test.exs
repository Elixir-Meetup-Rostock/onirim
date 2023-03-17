defmodule CardsTest do
  alias Cards.Door
  alias Cards.Dream
  alias Cards.Location

  use ExUnit.Case

  test "Create door card (aquarium)" do
    assert Cards.Door.new(:aquarium) == %Door{suit: :aquarium}
  end

  test "Create dream card (nightmare)" do
    assert Cards.Dream.new(:nightmare) == %Dream{type: :nightmare}
  end

  test "Create location card (aquarium key)" do
    assert Cards.Location.new(:aquarium, :key) == %Location{suit: :aquarium, symbol: :key}
  end

  # TODO Weniger Heisentestig
  test "Shuffle pile" do
    state = Phases.Setup.default_setup()

    pile_a =
      state
      |> Map.get(:draw_pile)

    pile_b =
      state
      |> Cards.shuffle(:draw_pile)
      |> Map.get(:draw_pile)

    refute pile_a == pile_b
  end
end
