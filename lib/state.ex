defmodule State do
  defstruct draw_pile: [],
            discard_pile: [],
            labyrinth: [],
            limbo_pile: [],
            opened_doors: [],
            personal_resources: [],
            phase: :unknown,
            status: :unknown,
            drawn_card: nil
end
