defmodule Deck do
  alias Cards.Door
  alias Cards.Dream
  alias Cards.Location

  # TODO Einfachen GameLoop bauen (Win, Loss, UserInput)
  # TODO StateMachine Skizzieren
  # TODO Weitere Funktionen implementieren
  # TODO Mehr Tests!

  @default_draw_pile_input Application.compile_env(:onirim, :default_draw_pile)

  def add_cards(cards, card, count \\ 1)
  def add_cards(cards, card, 1), do: [card | cards]
  def add_cards(cards, card, count), do: add_cards([card | cards], card, count - 1)

  def get_draw_pile(input) do
    input
    |> Enum.map(&to_cards/1)
    |> Enum.concat()
  end

  def to_cards({:dream, type, count}),
    do: List.duplicate(Dream.new(type), count)

  def to_cards({:door, suit, count}),
    do: List.duplicate(Door.new(suit), count)

  def to_cards({:location, suit, symbol, count}),
    do: List.duplicate(Location.new(suit, symbol), count)

  def get_default_draw_pile do
    @default_draw_pile_input
    |> get_draw_pile()
  end

  def show(cards) do
    cards
    |> Enum.each(&IO.inspect/1)
  end
end
