defmodule Phases.RefillHand do
  alias Cards.Door
  alias Cards.Dream
  alias Cards.Location

  @personal_ressources_limit Application.compile_env(:onirim, :personal_ressources_limit)

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

  def resolve_nightmare_with_key(
        state = %State{drawn_card: %Dream{type: :nightmare}},
        key = %Location{symbol: :key}
      ) do
    state
    |> Cards.move(:personal_resources, :discard_pile, key)
    |> Cards.move_drawn_card(:discard_pile)
  end

  def resolve_nightmare_with_door(
        state = %State{drawn_card: %Dream{type: :nightmare}},
        door = %Door{}
      ) do
    state
    |> Cards.move(:opened_doors, :limbo_pile, door)
    |> Cards.move_drawn_card(:discard_pile)
  end

  def resolve_nightmare_with_top_five_Cards(state = %State{drawn_card: %Dream{type: :nightmare}}) do
    {final_state, _} =
      state.draw_pile
      |> Enum.reduce_while({state, 0}, fn card, {current_state, counter} ->
        if counter < 5 do
          case card do
            %Location{} ->
              new_state = Cards.move_top_card(current_state, :draw_pile, :discard_pile)
              {:cont, {new_state, counter + 1}}

            _ ->
              new_state = Cards.move_top_card(current_state, :draw_pile, :limbo_pile)
              {:cont, {new_state, counter + 1}}
          end
        else
          {:halt, {current_state, counter}}
        end
      end)

    final_state
  end

  def refill_personal_resources(state = %State{}) do
    state.draw_pile
    |> Enum.reduce_while(state, fn card, state ->
      if Enum.count(state.personal_resources) < @personal_ressources_limit do
        case card do
          %Location{} ->
            new_state = Cards.move_top_card(state, :draw_pile, :personal_resources)
            {:cont, new_state}

          _ ->
            new_state = Cards.move_top_card(state, :draw_pile, :limbo_pile)
            {:cont, new_state}
        end
      else
        {:halt, state}
      end
    end)
  end
end
