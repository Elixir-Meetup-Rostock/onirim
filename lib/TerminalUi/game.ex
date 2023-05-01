defmodule TerminalUi.Game do
  alias Onirim.Core
  alias Onirim.Core.Phases
  alias Onirim.State

  def handle_actions(%State{} = state) do
    state
    # |> basic_actions()
    |> handle_phases()
  end

  def handle_phases(%State{phase: :play_or_discard} = state),
    do: state |> TerminalUi.PlayOrDiscard.start()

  def handle_phases(%State{phase: :refill_hand} = state),
    do: state |> TerminalUi.RefillHand.start()

  def handle_phases(%State{phase: :shuffle_limbo} = state),
    do: state |> TerminalUi.ShuffleLimbo.start()

  def run do
    Phases.Setup.default_setup()
    |> run()
  end

  def run(%State{} = state) do
    state
    |> handle_actions()
    |> Core.victory?()
    |> Core.defeat?()
    |> run()
  end

  def run(%State{status: :quit}), do: :noop

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
end
