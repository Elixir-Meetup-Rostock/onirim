defmodule Phases.PlayOrDiscard do
  alias Cards.Location
  alias Deck

  def play_card(state = %State{}, card) do
    state
    |> add_card(:labyrinth, card)
    |> remove_card(:personal_resources, card)
  end

  def discard_card(state = %State{}, card = %Location{symbol: :key}) do
    trigger_prophecy(state, card)
    remove_card(state, :personal_resources, card)
  end

  def discard_card(state = %State{}, card = %Location{}) do
    remove_card(state, :personal_resources, card)
  end

  def trigger_prophecy(state = %State{}, card) do
  end

  def add_card(state = %State{}, pile, card) do
    card_pile =
      state
      |> Map.get(pile)

    state
    |> Map.put(pile, Deck.add_cards(card_pile, card))
  end

  def remove_card(state = %State{}, pile, card) do
    index =
      state
      |> Map.get(pile)
      |> Enum.find_index(&(&1 = card))

    card_pile =
      state
      |> Map.get(pile)
      |> List.delete_at(index)

    state
    |> Map.put(:discard_pile, Deck.add_cards(state.discard_pile, card))
    |> Map.put(pile, card_pile)
  end
end
