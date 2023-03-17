defmodule TerminalUi.ShuffleLimbo do
  def start(%State{} = state) do
    Prompt.display("Entered Phase 3 - Shuffle Limbo")

    state
    |> Phases.ShuffleLimbo.resolve_limbo()
  end
end
