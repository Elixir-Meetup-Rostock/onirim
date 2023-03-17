defmodule TerminalUi.PlayOrDiscard do
  def start(%State{} = state) do
    Prompt.display("Entered Phase 1 - Play or Discard")

    state
    |> play_or_discard()
  end

  def play_or_discard(%State{} = state) do
    Prompt.select("Choose Action:", [
      {"Play", :play},
      {"Discard", :discard}
    ])
    |> case do
      :play -> play_card(state)
      :discard -> discard_card(state)
    end
  end

  def play_card(%State{} = state) do
    Prompt.display("Select card to play:")

    card =
      state
      |> State.set_phase(:play_or_discard, :choose_card_to_play)
      |> choose_card(:personal_resources)

    state
    |> Phases.PlayOrDiscard.play_card(card)
  end

  def discard_card(%State{} = state) do
    Prompt.display("Select card to discard:")

    state
    |> State.set_phase(:play_or_discard, :choose_card_to_discard)
    |> choose_card(:personal_resources)
    |> case do
      %{symbol: :key} = card ->
        Phases.PlayOrDiscard.discard_card(state, card) |> handle_prophecy(card)

      card ->
        Phases.PlayOrDiscard.discard_card(state, card)
    end
  end

  def handle_prophecy(%State{} = state, _card) do
    Prompt.display("Select prophecy card to discard:")

    card = choose_card(state, :prophecy_pile)

    state
    |> Phases.PlayOrDiscard.remove_prophecy_card(card)
    |> change_prophecy_pile_order()
  end

  def change_prophecy_pile_order(%State{prophecy_pile: prophecy_pile} = state)
      when length(prophecy_pile) === 0 do
    Prompt.display("Prophecy sorting done.")

    state
    |> Phases.PlayOrDiscard.resolve_prophecy()
  end

  def change_prophecy_pile_order(%State{} = state) do
    Prompt.display("Select next card to resolve prophecy:")

    card = choose_card(state, :prophecy_pile)

    state
    |> Cards.move(:prophecy_pile, :prophecy_pile_new, card)
    |> change_prophecy_pile_order()
  end

  def choose_card(%State{} = state, cards_pile) do
    pile = state |> Map.get(cards_pile)

    selects =
      pile
      |> Enum.with_index()
      |> Enum.map(fn {card, index} -> {TerminalUi.display_card(card), index} end)

    Prompt.select("", selects)
    |> case do
      index -> Enum.at(pile, index)
    end
  end
end
