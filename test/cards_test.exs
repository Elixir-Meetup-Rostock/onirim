defmodule CardsTest do
  alias Cards.Location
  use ExUnit.Case

  test "get aquarium key" do
    assert Cards.Location.get_aquarium_key() == %Location{symbol: :key, type: :aquarium}
  end
end
