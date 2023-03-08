defmodule State do
  defstruct draw_pile: [],
            discard_pile: [],
            labyrinth: [],
            limbo_pile: [],
            opened_doors: [],
            personal_resources: [],
            phase: :unknown,
            prophecy_pile: [],
            status: :unknown,
            drawn_card: nil
end
