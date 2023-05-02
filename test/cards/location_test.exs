defmodule LocationTest do
  alias Onirim.Core.Cards.Location

  use ExUnit.Case

  test "Create location card (aquarium key)" do
    assert Location.new(:aquarium, :key) == %Location{suit: :aquarium, symbol: :key}
  end

  test "Create random location card" do
    assert %Location{} = Location.random()
  end
end
