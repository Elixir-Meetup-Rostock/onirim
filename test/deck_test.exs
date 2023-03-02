defmodule DeckTest do
  use ExUnit.Case

  alias Cards.Dream
  alias Cards.Door
  alias Cards.Location

  def get_default_draw_pile do
    []
    |> Deck.add_cards(Dream.new(:nightmare), 10)
    |> Deck.add_cards(Door.new(:aquarium), 2)
    |> Deck.add_cards(Door.new(:garden), 2)
    |> Deck.add_cards(Door.new(:library), 2)
    |> Deck.add_cards(Door.new(:observatory), 2)
    |> Deck.add_cards(Location.new(:aquarium, :key), 3)
    |> Deck.add_cards(Location.new(:aquarium, :moon), 4)
    |> Deck.add_cards(Location.new(:aquarium, :sun), 8)
    |> Deck.add_cards(Location.new(:garden, :key), 3)
    |> Deck.add_cards(Location.new(:garden, :moon), 4)
    |> Deck.add_cards(Location.new(:garden, :sun), 7)
    |> Deck.add_cards(Location.new(:library, :key), 3)
    |> Deck.add_cards(Location.new(:library, :moon), 4)
    |> Deck.add_cards(Location.new(:library, :sun), 6)
    |> Deck.add_cards(Location.new(:observatory, :key), 3)
    |> Deck.add_cards(Location.new(:observatory, :moon), 4)
    |> Deck.add_cards(Location.new(:observatory, :sun), 9)
  end

  test "tupel to cards, count check" do
    count =
      {:dream, :nightmare, 10}
      |> Deck.to_cards([])
      |> Enum.count()

    assert count == 10
  end

  test "tupel to cards, type check" do
    first =
      {:dream, :nightmare, 10}
      |> Deck.to_cards([])
      |> List.first()

    assert first.type == :nightmare
  end

  test "tupel to cards, type and symbol check" do
    first =
      {:location, :aquarium, :key, 10}
      |> Deck.to_cards([])
      |> List.first()

    assert first == %Location{type: :aquarium, symbol: :key}
  end

  test "get draw pile, type and symbol check" do
    count =
      [{:dream, :nightmare, 1}]
      |> Deck.get_draw_pile()
      |> Enum.count()

    assert count == 2
  end

  # test "build default draw pile" do
  #   count =
  #     Deck.get_default_draw_pile()
  #     |> IO.inspect()
  #     |> Enum.count()

  #   assert count == 76
  # end

  # test "show cards in pile" do
  #   Deck.get_default_draw_pile()
  #   |> Deck.show()

  #   assert true
  # end
end
