defmodule TerminalUi.RefillHand do
  def start(%State{} = state) do
    Prompt.display("Entered Phase 2 - Refill")

    state
    |> State.set_phase(:shuffle_limbo, :start)
  end
end
