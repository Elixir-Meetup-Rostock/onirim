defmodule Onirim.Core.Cards do
  alias Onirim.Core.Cards
  alias Onirim.Core.Cards.Door
  alias Onirim.Core.Cards.Dream
  alias Onirim.Core.Cards.Location
  alias Onirim.State

  def add_cards(cards, card, count \\ 1)
  def add_cards(cards, card, 1), do: [card | cards]
  def add_cards(cards, card, count), do: add_cards([card | cards], card, count - 1)

  def add(%State{} = state, pile, card) do
    Map.update!(state, pile, &[card | &1])
  end

  def has(%State{} = state, pile, card) do
    state
    |> Map.get(pile)
    |> Enum.member?(card)
  end

  def move(%State{} = state, from_pile, to_pile) do
    state
    |> Map.update!(to_pile, &(Map.get(state, from_pile) ++ &1))
    |> Map.put(from_pile, [])
  end

  def move(%State{} = state, from_pile, to_pile, card) do
    state
    |> remove(from_pile, card)
    |> add(to_pile, card)
  end

  def move_drawn_card(%State{} = state, to_pile) do
    state
    |> add(to_pile, state.drawn_card)
    |> Map.put(:drawn_card, nil)
  end

  def remove(%State{} = state, pile, card) do
    Map.update!(state, pile, &List.delete(&1, card))
  end

  def move_top_card(%State{} = state, from_pile, to_pile) do
    card_pile = Map.get(state, from_pile)

    top_card =
      card_pile
      |> List.first()

    state
    |> Cards.add(to_pile, top_card)
    |> Map.put(from_pile, card_pile |> tl())
  end

  def random do
    1..3
    |> Enum.random()
    |> case do
      1 ->
        Cards.Door.random()

      2 ->
        Cards.Dream.random()

      _ ->
        Cards.Location.random()
    end
  end

  def shuffle(%State{} = state, pile) do
    Map.update!(state, pile, &Enum.shuffle/1)
  end

  def location?(%Location{}), do: true
  def location?(_), do: false

  def dream?(%Dream{}), do: true
  def dream?(_), do: false

  def door?(%Door{}), do: true
  def door?(_), do: false
end
