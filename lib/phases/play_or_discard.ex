defmodule Phases.PlayOrDiscard do
  alias Cards.Door
  alias Cards
  alias Cards.Location
  alias Deck

  def discard_card(state = %State{}, card = %Location{symbol: :key}) do
    state
    |> trigger_prophecy(card)
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

  # TODO Check ob die gewählte Karte gelegt werden darf
  def play_card(state = %State{}, card = %Location{}) do
    state
    |> Cards.move(:personal_resources, :labyrinth, card)
    |> open_door?()
    |> case do
      {state, true, suit} -> open_door(state, suit)
      {state, _, _} -> state
    end
  end

  def trigger_prophecy(state = %State{}, _card) do
    IO.puts("Trigger Prophecy is not implemented")
    state
  end
end
