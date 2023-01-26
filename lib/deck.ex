defmodule Deck do
  defstruct cards: []

  alias Cards.Door
  alias Cards.Dream
  alias Cards.Location

  def add_cards(deck, card, count \\ 1) do
    cards =
      1..count
      |> Enum.reduce(deck.cards, fn _, cards_acc ->
        [card | cards_acc]
      end)

    %Deck{
      cards: cards
    }
  end

  def empty?(deck) do
    Enum.empty?(deck.cards)
  end

  def get_default_deck do
    %Deck{}
    |> add_cards(Dream.get_nightmare(), 10)
    |> add_cards(Door.get_aquarium_door(), 2)
    |> add_cards(Door.get_garden_door(), 2)
    |> add_cards(Door.get_library_door(), 2)
    |> add_cards(Door.get_observatory_door(), 2)
    |> add_cards(Location.get_aquarium_key(), 3)
    |> add_cards(Location.get_aquarium_moon(), 4)
    |> add_cards(Location.get_aquarium_sun(), 8)
    |> add_cards(Location.get_garden_key(), 3)
    |> add_cards(Location.get_garden_moon(), 4)
    |> add_cards(Location.get_garden_sun(), 7)
    |> add_cards(Location.get_library_key(), 3)
    |> add_cards(Location.get_library_moon(), 4)
    |> add_cards(Location.get_library_sun(), 6)
    |> add_cards(Location.get_observatory_key(), 3)
    |> add_cards(Location.get_observatory_moon(), 4)
    |> add_cards(Location.get_observatory_sun(), 9)
  end

  def report do
  end

  def show(deck) do
    deck.cards
    |> Enum.each(fn card -> IO.inspect(card) end)
  end

  def shuffle(deck) do
    %Deck{
      cards: Enum.shuffle(deck.cards)
    }
  end
end
