defmodule DoorTest do
  alias Onirim.Core.Cards.Door

  use ExUnit.Case

  test "Create door card (aquarium)" do
    assert Door.new(:aquarium) == %Door{suit: :aquarium}
  end

  test "Create random door card" do
    assert %Door{} = Door.random()
  end
end
