defmodule Onirim.Core.Phases.ShuffleLimbo do
  alias Onirim.State

  def resolve_limbo(%State{} = state) do
    if Enum.empty?(state.limbo_pile) do
      state
    else
      state
      |> Map.put(:draw_pile, (state.draw_pile ++ state.limbo_pile) |> Enum.shuffle())
      |> Map.put(:limbo_pile, [])
    end
    |> State.set_phase(:play_or_discard, :start)
  end
end
