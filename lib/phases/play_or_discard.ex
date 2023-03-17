defmodule Phases.PlayOrDiscard do
  alias Cards
  alias Cards.Door
  alias Cards.Location

  def discard_card(%State{} = state, %Location{symbol: :key} = card) do
    state
    |> Cards.move(:personal_resources, :discard_pile, card)
    |> Map.put(:prophecy_pile, state.draw_pile |> Enum.take(5))
    |> State.set_phase(:play_or_discard, :choose_card_to_remove)
  end

  def discard_card(%State{} = state, %Location{} = card) do
    state
    |> Cards.move(:personal_resources, :discard_pile, card)
    |> State.set_phase(:refill_hand, :draw)
  end

  def open_door(%State{} = state, %Door{} = door) do
    state
    |> Cards.move(:draw_pile, :opened_doors, door)
    |> Cards.shuffle(:draw_pile)
    |> State.set_phase(:refill_hand, :draw)
  end

  def three_cards?(labyrinth) when length(labyrinth) >= 3, do: true
  def three_cards?(_labyrinth), do: false

  def three_same_suits?(labyrinth, suit) do
    labyrinth
    |> Enum.take(3)
    |> Enum.all?(&(&1.suit == suit))
  end

  def open_door?(%State{labyrinth: labyrinth} = state) do
    suit =
      labyrinth
      |> List.first()
      |> Map.get(:suit)

    if three_cards?(labyrinth) and three_same_suits?(labyrinth, suit) do
      {state, true, %Door{suit: suit}}
    else
      {state, false, nil}
    end
  end

  def play_card(state = %State{labyrinth: [%{symbol: symbol_1}]}, %Location{symbol: symbol_2})
      when symbol_1 == symbol_2,
      do: state

  def play_card(%State{} = state, %Location{} = card) do
    state
    |> Cards.move(:personal_resources, :labyrinth, card)
    |> open_door?()
    |> case do
      {state, true, suit} -> open_door(state, suit)
      {state, _, _} -> state
    end
    |> State.set_phase(:refill_hand, :draw)
  end

  def remove_prophecy_card(%State{} = state, card) do
    state
    |> Map.update!(:prophecy_pile, &List.delete(&1, card))
    |> State.set_phase(:refill_hand, :choose_new_order)
  end

  def resolve_prophecy(%State{} = state) do
    state
    |> Cards.move(:prophecy_pile_new, :draw_pile)
    |> State.set_phase(:refill_hand, :draw)
  end
end
