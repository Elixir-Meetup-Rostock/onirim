defmodule Onirim do
  alias Phases.PlayOrDiscard
  alias Game
  alias Cards.Location

  # TODO Game Loop vervollständigen
  def loop do
    handle_init()
  end

  def handle_init do
    IO.puts("Enter 's' for Setup and 'q' for quit")

    IO.gets("")
    |> String.trim()
    |> case do
      "s" ->
        IO.puts("Default Setup - START")

        state =
          Phases.Setup.default_setup()
          |> IO.inspect()

        IO.puts("Default Setup - DONE")

        handle_play_or_discard(state)

      "q" ->
        IO.puts("Ney")

      input ->
        IO.warn("Invalid input: '#{input}'")
    end
  end

  def handle_play_or_discard(state = %State{}) do
    IO.puts("Enter '1' for Playing a card or '2' discarding a card")

    IO.gets("")
    |> String.trim()
    |> case do
      "1" ->
        IO.puts("Which card do you want to play?")
        state |> list_personal_resources()

        {input, _} = IO.getn("") |> Integer.parse()
        card = state.personal_resources |> Enum.at(input)

        state
        |> PlayOrDiscard.play_card(card)
        |> IO.inspect()

      "2" ->
        IO.puts("Which card do you want to dicsard?")
        state |> list_personal_resources()

        {input, _} = IO.getn("") |> Integer.parse()
        card = state.personal_resources |> Enum.at(input)

        state
        |> PlayOrDiscard.discard_card(card)
        |> IO.inspect()

      input ->
        IO.warn("Invalid input: '#{input}'")
    end
  end

  def list_personal_resources(%State{personal_resources: cards}) do
    cards
    |> Enum.with_index()
    |> Enum.each(&print_location/1)
  end

  def print_location({%Location{suit: suit, symbol: symbol}, index}) do
    IO.puts("[#{index}] - #{suit} #{symbol}")
  end
end
