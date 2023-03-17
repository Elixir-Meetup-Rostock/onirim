defmodule TerminalUi do
  alias Cards.Location
  alias Phases.PlayOrDiscard
  alias Phases.Setup
  alias Prompt
  alias State

  def run do
    Prompt.display("Welcome to onirim!")

    Prompt.confirm("Do you want to start the default setup?")
    |> case do
      :yes ->
        Setup.default_setup()
        |> handle_play_or_discard()

      _ ->
        Prompt.display("Bye!")
    end
  end

  def handle_play_or_discard(%State{} = state) do
    Prompt.select("Choose an action", [
      {"Play a card", :play},
      {"Discard a card", :discard}
    ])
    |> case do
      :play ->
        state
        |> handle_play_card()

      :discard ->
        state
    end
  end

  def get_location_label(%Location{suit: suit, symbol: symbol}) do
    "#{suit} #{symbol}"
  end

  def handle_play_card(%State{} = state) do
    cards_for_prompt =
      state.personal_resources
      |> Enum.with_index()
      |> Enum.map(fn {card, index} -> {get_location_label(card), index} end)

    index = Prompt.select("Choose a card", cards_for_prompt)

    card =
      state.personal_resources
      |> Enum.at(index)

    state
    |> PlayOrDiscard.play_card(card)
  end
end
