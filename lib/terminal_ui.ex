defmodule TerminalUi do
  alias Onirim.Core.Cards.Door
  alias Onirim.Core.Cards.Dream
  alias Onirim.Core.Cards.Location
  alias Onirim.State
  alias Prompt

  def choose_card(%State{} = state, cards_pile) do
    state
    |> Map.get(cards_pile)
    |> choose_card()
  end

  def choose_card(cards) do
    selects =
      cards
      |> Enum.with_index()
      |> Enum.map(fn {card, index} -> {TerminalUi.display_card(card), index} end)

    Prompt.select("", selects)
    |> case do
      index -> Enum.at(cards, index)
    end
  end

  def display_cards(cards) do
    cards
    |> Enum.map(&display_card/1)
    |> Prompt.display()
  end

  def display_card(%Location{suit: suit, symbol: symbol}), do: "Location - #{suit} #{symbol}"

  def display_card(%Dream{type: type}), do: "Dream - #{type}"

  def display_card(%Door{suit: suit}), do: "Door - #{suit}"

  def start do
    TerminalUi.Game.run()
  end
end
