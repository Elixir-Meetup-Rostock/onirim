defmodule Phases.RefillHand do
  alias Cards.Location

  def discard_and_refill_personal_resources(state = %State{}) do
    state
    |> discard_personal_resources()
    |> refill_personal_resources()
  end

  def discard_personal_resources(state = %State{}) do
    state.personal_resources
    |> Enum.map(&Cards.move(state, :personal_resources, :discard_pile, &1))

    state
  end

  # TODO Refactor discard_top_five_cards_from_draw_pile + Tests
  def discard_top_five_cards_from_draw_pile(state = %State{}) do
    state.draw_pile
    |> Enum.reduce_while({state, 0}, fn card, {state, counter} ->
      if counter < 5 do
        state = Map.put(state, :draw_pile, state.draw_pile |> tl())

        case card do
          %Location{} ->
            state = Map.put(state, :discard_pile, [card, state.discard_pile])
            {:cont, {state, counter + 1}}

          _ ->
            Map.put(state, :limbo_pile, [card, state.limbo_pile])
            {:cont, {state, counter}}
        end
      else
        {:halt, {state, counter}}
      end
    end)

    state
  end

  def draw_card(state = %State{}) do
    drawn_card = state.draw_pile |> List.first()

    state
    |> Map.put(:drawn_card, drawn_card)
    |> Cards.remove(:draw_pile, drawn_card)
  end

  def resolve_drawn_location(state = %State{}) do
    state
    |> Cards.add(:personal_resources, state.drawn_card)
    |> Map.put(:drawn_card, nil)
  end

  def resolve_drawn_door(state = %State{}) do
    state
    |> Cards.add(:limbo_pile, state.drawn_card)
    |> draw_card()
  end

  def open_drawn_door?(state = %State{}) do
    key_card = Location.new(state.drawn_card.suit, :key)

    has_key_card =
      state
      |> Cards.has(:pesonal_resources, key_card)

    {has_key_card, key_card}
  end

  def open_drawn_door(state = %State{}) do
    state
    |> open_drawn_door?
    |> case do
      {true, key_card} ->
        state
        |> Cards.add(:opened_doors, state.drawn_card)
        |> Cards.remove(:personal_resources, key_card)
        |> Map.put(:drawn_card, nil)

      _ ->
        state
    end
  end

  # TODO Implement full Handling
  def resolve_drawn_dream(state = %State{}) do
    state
    |> Cards.add(:limbo_pile, state.drawn_card)
    |> draw_card()
  end

  def peek_card(state = %State{}) do
    state.draw_pile |> List.first()
  end

  # TODO Tests
  def refill_personal_resources(state = %State{}) do
    state.draw_pile
    |> Enum.reduce_while(state, fn card, state ->
      if Enum.count(state.personal_resources) < 5 do
        case card do
          %Location{} ->
            state = Cards.add(state, :personal_resources, card)
            {:cont, state}

          _ ->
            state = Cards.add(state, :limbo_pile, card)
            {:cont, state}
        end
      else
        {:halt, state}
      end
    end)
  end
end
