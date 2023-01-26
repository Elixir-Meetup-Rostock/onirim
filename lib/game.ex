defmodule Game do
  def resolve_limbo(state) do
    if Deck.empty?(state.limbo_pile) do
      state
    else
      draw_pile =
        %Deck{}
        |> Map.put(:cards, state.draw_pile.cards ++ state.limbo_pile.cards)
        |> Deck.shuffle()

      state
      |> Map.put(:draw_pile, draw_pile)
      |> Map.put(:limbo_pile, %Deck{})
    end
  end

  def setup do
    %State{
      draw_pile: Deck.get_default_deck() |> Deck.shuffle()
    }
  end
end
