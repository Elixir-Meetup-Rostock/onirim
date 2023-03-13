defmodule Phases.PlayOrDiscard do
  alias Cards
  alias Cards.Door
  alias Cards.Location

  def discard_card(state = %State{}, card = %Location{symbol: :key}) do
    state
    |> trigger_prophecy
    |> Cards.move(:personal_resources, :discard_pile, card)
  end

  def discard_card(state = %State{}, card = %Location{}) do
    state
    |> Cards.move(:personal_resources, :discard_pile, card)
  end

  def open_door(state = %State{}, %Door{} = door) do
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

  def open_door?(state = %State{labyrinth: labyrinth}) do
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

  def play_card(state = %State{labyrinth: [%{symbol: s1}]}, %Location{symbol: s2}) when s1 == s2,
    do: state

  def play_card(state = %State{}, card = %Location{}) do
    state
    |> Cards.move(:personal_resources, :labyrinth, card)
    |> open_door?()
    |> case do
      {state, true, suit} -> open_door(state, suit)
      {state, _, _} -> state
    end
  end

  def trigger_prophecy(state = %State{}) do
    top_five_cards =
      state.draw_pile
      |> Enum.take(5)

    state
    |> Map.put(:prophecy_pile, top_five_cards)
  end

  def remove_prophecy_card(state = %State{}, card) do
    state.prophecy_pile
    |> Enum.member?(card)
    |> if do
      new_prophecy_pile = state.prophecy_pile |> List.delete(card)
      Map.put(state, :prophecy_pile, new_prophecy_pile)
    else
      state
    end
  end

  def sort_prophecy_pile(state = %State{}, cards) do
    Map.put(state, :prophecy_pile, cards)
  end

  def resolve_prophecy(state = %State{}) do
    new_draw_pile = Enum.concat(state.prophecy_pile, state.draw_pile)

    Map.put(state, :draw_pile, new_draw_pile)
  end
end
