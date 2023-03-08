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

  def open_door(state = %State{}, suit) do
    state
    |> Cards.move(:draw_pile, :opened_doors, Door.new(suit))
    |> Cards.shuffle(:draw_pile)
  end

  def open_door?(state = %State{labyrinth: labyrinth}) do
    last_three_cards =
      labyrinth
      |> Enum.take(3)

    if last_three_cards |> Enum.count() == 3 do
      suit =
        last_three_cards
        |> List.first()
        |> Map.get(:suit)

      if last_three_cards |> Enum.all?(&(&1.suit == suit)) do
        {state, true, suit}
      else
        {state, false, nil}
      end
    else
      {state, false, nil}
    end
  end

  def play_card?(state = %State{}, card = %Location{}) do
    state.labyrinth
    |> List.first()
    |> case do
      nil -> true
      last_location -> last_location.suit != card.suit
    end
  end

  def play_card(state = %State{}, card = %Location{}) do
    state
    |> play_card?(card)
    |> if do
      state
      |> Cards.move(:personal_resources, :labyrinth, card)
      |> open_door?()
      |> case do
        {state, true, suit} -> open_door(state, suit)
        {state, _, _} -> state
      end
    else
      state
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
