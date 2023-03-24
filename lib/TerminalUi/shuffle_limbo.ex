defmodule TerminalUi.ShuffleLimbo do
  alias Onirim.Core.Phases
  alias Onirim.State

  def start(%State{} = state) do
    Prompt.display("Entered Phase 3 - Shuffle Limbo")

    state
    |> Phases.ShuffleLimbo.resolve_limbo()
  end
end
