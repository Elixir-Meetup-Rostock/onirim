defmodule Phases.Setup do
  alias Deck

  def default_setup do
    %State{
      draw_pile: Deck.get_default_draw_pile() |> Enum.shuffle(),
      phase: :play_or_discard,
      status: :active
    }
  end
end
