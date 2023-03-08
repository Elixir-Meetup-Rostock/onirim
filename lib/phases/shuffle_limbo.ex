defmodule Phases.ShuffleLimbo do
  def resolve_limbo(state = %State{}) do
    if Enum.empty?(state.limbo_pile) do
      state
    else
      state
      |> Map.put(:draw_pile, (state.draw_pile ++ state.limbo_pile) |> Enum.shuffle())
      |> Map.put(:limbo_pile, [])
    end
    |> Map.put(:phase, :play_or_discard)
  end
end
