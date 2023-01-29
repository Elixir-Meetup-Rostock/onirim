defmodule State do
  defstruct active_card: :unknown,
            draw_pile: [],
            discard_pile: [],
            labyrinth: [],
            limbo_pile: [],
            opened_doors: [],
            personal_resources: []
end
