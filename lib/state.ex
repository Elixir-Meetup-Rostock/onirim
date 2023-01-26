defmodule State do
  defstruct draw_pile: %Deck{},
            discard_pile: %Deck{},
            labyrinth: [],
            limbo_pile: %Deck{},
            opened_doors: %Deck{},
            personal_resources: %Deck{}
end
