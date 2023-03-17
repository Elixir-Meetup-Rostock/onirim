defmodule TerminalUi do
  alias Cards.Door
  alias Cards.Dream
  alias Cards.Location
  alias Prompt
  alias State

  # @info_actions [
  #   {"Show personal resources", :personal_resources},
  #   {"Show discard pile", :discard_pile},
  #   {"Show limbo pile", :limbo_pile},
  #   {"Show labyrinth", :labyrinth},
  #   {"Show draw pile", :draw_pile},
  #   {"Show state", :state}
  # ]

  # def basic_actions(%State{} = state) do
  #   next_action = get_next_actions(state)

  #   Prompt.select("Choose an action", @info_actions ++ next_action)
  #   |> case do
  #     :state ->
  #       state
  #       |> IO.inspect(label: "State: ")

  #     cards_key ->
  #       state
  #       |> Map.get(cards_key)
  #       |> display_cards()
  #   end

  #   state
  # end

  def handle_phases(%State{phase: :play_or_discard} = state),
    do: state |> TerminalUi.PlayOrDiscard.start()

  def handle_phases(%State{phase: :refill_hand} = state),
    do: state |> TerminalUi.RefillHand.start()

  def handle_phases(%State{phase: :shuffle_limbo} = state),
    do: state |> TerminalUi.ShuffleLimbo.start()

  def display_cards(cards) do
    cards
    |> Enum.map(&display_card/1)
    |> Prompt.display()
  end

  def display_card(%Location{suit: suit, symbol: symbol}), do: "Location - #{suit} #{symbol}"

  def display_card(%Dream{type: type}), do: "Dream - #{type}"

  def display_card(%Door{suit: suit}), do: "Door - #{suit}"
end
