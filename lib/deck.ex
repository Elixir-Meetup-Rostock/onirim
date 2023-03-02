defmodule Deck do
  alias Cards.Door
  alias Cards.Dream
  alias Cards.Location

  # TODO Liste von Tupeln, Variabler Input
  # TODO Einfachen GameLoop bauen (Win, Loss, UserInput)
  # TODO StateMachine Skizzieren
  # TODO Weitere Funktionen implementieren
  # TODO Mehr Tests!

  @default_draw_pile_input [
    {:dream, :nightmare, 10},
    {:door, :aquarium, 2},
    {:door, :garden, 2},
    {:door, :library, 2},
    {:door, :observatory, 2},
    {:location, :aquarium, :key, 3},
    {:location, :aquarium, :moon, 4},
    {:location, :aquarium, :sun, 8},
    {:location, :garden, :key, 3},
    {:location, :garden, :moon, 4},
    {:location, :garden, :sun, 7},
    {:location, :library, :key, 3},
    {:location, :library, :moon, 4},
    {:location, :library, :sun, 6},
    {:location, :observatory, :key, 3},
    {:location, :observatory, :moon, 4},
    {:location, :observatory, :sun, 9}
  ]

  def add_cards(cards, card, count \\ 1)
  def add_cards(cards, card, 1), do: [card | cards]
  def add_cards(cards, card, count), do: add_cards([card | cards], card, count - 1)

  def get_draw_pile(input) do
    Enum.map_reduce(input, [], fn item, draw_pile ->
      to_cards(item, draw_pile)
    end)
  end

  def to_cards({:dream, type, count}, draw_pile),
    do: add_cards(draw_pile, Dream.new(type), count)

  def to_cards({:door, type, count}, draw_pile),
    do: add_cards(draw_pile, Door.new(type), count)

  def to_cards({:location, type, symbol, count}, draw_pile),
    do: add_cards(draw_pile, Location.new(type, symbol), count)

  def get_default_draw_pile do
    @default_draw_pile_input
    |> get_draw_pile()
  end

  def show(cards) do
    cards
    |> Enum.each(&IO.inspect(&1))
  end
end
