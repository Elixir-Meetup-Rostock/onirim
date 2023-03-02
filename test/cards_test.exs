defmodule CardsTest do
  alias Cards.Location
  use ExUnit.Case

  test "get aquarium key" do
    assert Cards.Location.new(:aquarium, :key) == %Location{type: :aquarium, symbol: :key}
  end
end
