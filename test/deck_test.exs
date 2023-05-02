defmodule DeckTest do
  use ExUnit.Case

  alias Onirim.Core.Cards
  alias Onirim.Core.Cards.Door
  alias Onirim.Core.Cards.Dream
  alias Onirim.Core.Cards.Location
  alias Onirim.Core.Phases.Setup

  def get_default_draw_pile do
    []
    |> Cards.add_cards(Dream.new(:nightmare), 10)
    |> Cards.add_cards(Door.new(:aquarium), 2)
    |> Cards.add_cards(Door.new(:garden), 2)
    |> Cards.add_cards(Door.new(:library), 2)
    |> Cards.add_cards(Door.new(:observatory), 2)
    |> Cards.add_cards(Location.new(:aquarium, :key), 3)
    |> Cards.add_cards(Location.new(:aquarium, :moon), 4)
    |> Cards.add_cards(Location.new(:aquarium, :sun), 8)
    |> Cards.add_cards(Location.new(:garden, :key), 3)
    |> Cards.add_cards(Location.new(:garden, :moon), 4)
    |> Cards.add_cards(Location.new(:garden, :sun), 7)
    |> Cards.add_cards(Location.new(:library, :key), 3)
    |> Cards.add_cards(Location.new(:library, :moon), 4)
    |> Cards.add_cards(Location.new(:library, :sun), 6)
    |> Cards.add_cards(Location.new(:observatory, :key), 3)
    |> Cards.add_cards(Location.new(:observatory, :moon), 4)
    |> Cards.add_cards(Location.new(:observatory, :sun), 9)
  end

  test "tupel to cards, count check" do
    count =
      {:dream, :nightmare, 10}
      |> Setup.to_cards()
      |> Enum.count()

    assert count == 10
  end

  test "tupel to cards, type check" do
    first =
      {:dream, :nightmare, 10}
      |> Setup.to_cards()
      |> List.first()

    assert first.type == :nightmare
  end

  test "tupel to cards, type and symbol check" do
    first =
      {:location, :aquarium, :key, 10}
      |> Setup.to_cards()
      |> List.first()

    assert first == %Location{suit: :aquarium, symbol: :key}
  end

  test "get draw pile, type and symbol check" do
    count =
      [{:dream, :nightmare, 2}]
      |> Setup.get_draw_pile()
      |> Enum.count()

    assert count == 2
  end

  test "build default draw pile" do
    count =
      Setup.get_default_draw_pile()
      |> Enum.count()

    assert count == 76
  end
end
