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
<<<<<<< HEAD
    @default_draw_pile_input
    |> get_draw_pile()
=======
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
>>>>>>> d0d08a36be9edb0a697a7c02ae5009a8f7f93082
  end

  def show(cards) do
    cards
    |> Enum.each(&IO.inspect(&1))
  end



end
