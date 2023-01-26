defmodule DeckTest do
  use ExUnit.Case

  alias Cards.Dream

  test "build default deck" do
    count =
      Deck.get_default_deck().cards
      |> Enum.count()

    assert count == 76
  end

  test "add card to deck" do
    deck =
      %Deck{}
      |> Deck.add_cards(Dream.get_nightmare())

    assert deck.cards |> Enum.count() == 1
  end

  test "show cards in deck" do
    Deck.get_default_deck()
    |> Deck.show()

    assert true
  end
end
