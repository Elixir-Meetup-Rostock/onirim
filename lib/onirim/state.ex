defmodule Onirim.State do
  defstruct draw_pile: [],
            discard_pile: [],
            drawn_card: nil,
            labyrinth: [],
            limbo_pile: [],
            opened_doors: [],
            personal_resources: [],
            phase: :unknown,
            sub_phase: :unknown,
            prophecy_pile: [],
            prophecy_pile_new: [],
            status: :unknown

  def set_phase(%__MODULE__{} = state, phase, sub_phase) do
    state
    |> Map.put(:phase, phase)
    |> Map.put(:sub_phase, sub_phase)
  end
end
