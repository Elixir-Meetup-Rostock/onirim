defmodule TerminalUi.RefillHand do
  alias Onirim.Core.Cards.Door
  alias Onirim.Core.Cards.Location
  alias Onirim.Core.Cards.Dream
  alias Onirim.Core.Phases
  alias Onirim.State

  # TODO Add Subphase Handling

  def start(%State{} = state) do
    Prompt.display("Entered Phase 2 - Refill")

    state
    |> draw_and_resolve()
    |> State.set_phase(:shuffle_limbo, :start)
  end

  def draw_and_resolve(%State{personal_resources: personal_resources} = state)
      when length(personal_resources) === 5 do
    state
  end

  def draw_and_resolve(%State{} = state) do
    state
    |> Phases.RefillHand.draw_card()
    |> resolve_drawn_card()
    |> draw_and_resolve()
  end

  def resolve_drawn_card(%State{drawn_card: %Location{} = card} = state) do
    Prompt.display(
      "You have drawn a location and put it on your hand: #{TerminalUi.display_card(card)}"
    )

    state
    |> Phases.RefillHand.resolve_drawn_location()
  end

  def resolve_drawn_card(%State{drawn_card: %Dream{} = card} = state) do
    Prompt.display(
      "You have drawn a dream and have to resolve it: #{TerminalUi.display_card(card)}"
    )

    Prompt.select("Choose Action:", get_options_to_resolve_nightmare(state))
    |> case do
      :discard_key -> discard_key(state)
      :discard_door -> discard_door(state)
      :discard_top_five -> discard_top_five(state)
      :discard_hand -> discard_hand(state)
    end
  end

  def resolve_drawn_card(%State{drawn_card: %Door{} = card} = state) do
    Prompt.display("You have drawn a door: #{TerminalUi.display_card(card)}")

    state
    |> Phases.RefillHand.open_drawn_door?()
    |> case do
      true ->
        state
        |> choose_to_open_door()

      false ->
        state
        |> Phases.RefillHand.resolve_drawn_door()
        |> draw_and_resolve()
    end
  end

  def discard_key(%State{drawn_card: %Dream{}} = state) do
    Prompt.display("Choose a key to discard: ")

    state
    |> Phases.RefillHand.get_keys()
    |> TerminalUi.choose_card()
    |> case do
      %Location{symbol: :key} = key -> Phases.RefillHand.resolve_nightmare_with_key(state, key)
    end
  end

  def discard_door(%State{drawn_card: %Dream{}} = state) do
    Prompt.display("Choose a door to discard: ")

    state.opened_doors
    |> TerminalUi.choose_card()
    |> case do
      %Door{} = door -> Phases.RefillHand.resolve_nightmare_with_door(state, door)
    end
  end

  def discard_top_five(%State{drawn_card: %Dream{}} = state) do
    state
    |> Phases.RefillHand.resolve_nightmare_with_top_five_cards()
  end

  def discard_hand(%State{drawn_card: %Dream{}} = state) do
    state
    |> Phases.RefillHand.resolve_nightmare_with_personal_resources()
  end

  def choose_to_open_door(%State{drawn_card: %Door{}} = state) do
    Prompt.confirm("Do you want to open the door?")
    |> case do
      :yes ->
        state
        |> Phases.RefillHand.open_drawn_door()

      :no ->
        state
        |> Phases.RefillHand.resolve_drawn_door()
        |> draw_and_resolve()

      _ ->
        state
        |> choose_to_open_door()
    end
  end

  def get_options_to_resolve_nightmare(%State{} = state) do
    []
    |> Utils.concat_if(
      {"Discard a key from your hand", :discard_key},
      Phases.RefillHand.resolve_nightmare_with_key?(state)
    )
    |> Utils.concat_if(
      {"Place one of your gained doors in the Limbo pile", :discard_door},
      Phases.RefillHand.resolve_nightmare_with_door?(state)
    )
    |> Utils.concat_if(
      {"Reveal top five cards and discard all locations", :discard_top_five},
      Phases.RefillHand.resolve_nightmare_with_top_five_cards?(state)
    )
    |> Utils.concat_if(
      {"Discard your whole hand", :discard_hand},
      Phases.RefillHand.resolve_nightmare_with_personal_resources?(state)
    )
  end
end
