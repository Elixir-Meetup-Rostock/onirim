defmodule Game do
  alias Cards.Location

  # TODO Resolve active card
  # TODO Play Card?
  # TODO Open Door?

  def add_card_to_pile(state = %State{}, pile, card) do
    card_pile = [card | state |> Map.get(pile)]

    Map.put(state, pile, card_pile)
  end

  def discard_and_refill_personal_resources(state = %State{}) do
    state
    |> discard_personal_resources()
    |> refill_personal_resources()
  end

  def discard_card(state = %State{}, pile, card) do
    index =
      state
      |> Map.get(pile)
      |> Enum.find_index(&(&1 = card))

    card_pile =
      state
      |> Map.get(pile)
      |> List.delete_at(index)

    Map.put(state, pile, card_pile)
  end

  def discard_personal_resources(state = %State{}) do
    state
    |> Map.put(:draw_pile, state.discard_pile ++ state.personal_resources)
    |> Map.put(:personal_resources, [])
  end

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

    # TODO GAME_OVER condition if counter < 5
    state
  end

  def draw_card(state = %State{}) do
    state
    |> Map.put(:active_card, state.draw_pile |> List.first())
    |> Map.put(:draw_pile, state.draw_pile |> tl())
  end

  def peek_card(state = %State{}) do
    state.draw_pile |> List.first()
  end

  def refill_personal_resources(state = %State{}) do
    state.draw_pile
    |> Enum.reduce_while(0, fn card, counter ->
      if counter < 3 do
        case card do
          %Location{} ->
            state = Map.put(state, :personal_resources, [card, state.personal_resources])
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
    |> resolve_limbo()
  end

  def resolve_limbo(state = %State{}) do
    if Enum.empty?(state.limbo_pile) do
      state
    else
      state
      |> Map.put(:draw_pile, (state.draw_pile ++ state.limbo_pile) |> Enum.shuffle())
      |> Map.put(:limbo_pile, [])
    end
  end

  def setup do
    %State{
      draw_pile: Deck.get_default_draw_pile() |> Enum.shuffle()
    }
  end
end
