defmodule Deck do
  alias Cards.Door
  alias Cards.Dream
  alias Cards.Location

  #TODO Liste von Tupeln, Variabler Input
  #TODO Einfachen GameLoop bauen (Win, Loss, UserInput)
  #TODO StateMachine Skizzieren
  #TODO Weitere Funktionen implementieren
  #TODO Mehr Tests!

  # def add_cards_r(cards, card, count \\ 1)
  # def add_cards_r(cards, card, 1), do: [card | cards]
  # def add_cards_r(cards, card, count), do: add_cards_r([card | cards], card, count - 1)

  def add_cards(cards, card, count \\ 1) do
    1..count
    |> Enum.reduce(cards, fn _, cards_acc -> [card | cards_acc] end)
  end

  def get_default_draw_pile do
    []
    |> add_cards(Dream.get_nightmare(), 10)
    |> add_cards(Door.new(:aquarium), 2)
    |> add_cards(Door.new(:garden), 2)
    |> add_cards(Door.new(:library), 2)
    |> add_cards(Door.new(:observatory), 2)
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

  def show(cards) do
    cards
    |> Enum.each(&IO.inspect(&1))
  end



end
