defmodule Phases.PlayOrDiscard do
  alias Cards
  alias Cards.Door
  alias Cards.Location

  def discard_card(%State{} = state, %Location{symbol: :key} = card) do
    state
    |> trigger_prophecy
    |> Cards.move(:personal_resources, :discard_pile, card)
  end

  def discard_card(%State{} = state, %Location{} = card) do
    state
    |> Cards.move(:personal_resources, :discard_pile, card)
  end

  def open_door(%State{} = state, %Door{} = door) do
    state
    |> Cards.move(:draw_pile, :opened_doors, door)
    |> Cards.shuffle(:draw_pile)
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
  end

  def trigger_prophecy(%State{} = state) do
    top_five_cards =
      state.draw_pile
      |> Enum.take(5)

    state
    |> Map.put(:prophecy_pile, state.draw_pile |> Enum.take(5))
  end

  def remove_prophecy_card(%State{} = state, card) do
    state.prophecy_pile
    |> Enum.member?(card)
    |> if do
      Map.update!(state, :prophecy_pile, &List.delete(&1, card))
    else
      state
    end
  end

  def sort_prophecy_pile(%State{} = state, cards) do
    Map.put(state, :prophecy_pile, cards)
  end

  def resolve_prophecy(%State{} = state) do
    Map.update!(state, :draw_pile, &Enum.concat(state.prophecy_pile, &1))
  end
end
