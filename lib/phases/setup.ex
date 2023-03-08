defmodule Phases.Setup do
  alias Cards.Door
  alias Cards.Dream
  alias Cards.Location

  @default_draw_pile_input Application.compile_env(:onirim, :default_draw_pile)

  def default_setup do
    %State{
      draw_pile: get_default_draw_pile() |> Enum.shuffle(),
      phase: :play_or_discard,
      status: :active
    }
    |> Phases.RefillHand.refill_personal_resources()
    |> Phases.ShuffleLimbo.resolve_limbo()
  end

  def get_draw_pile(input) do
    input
    |> Enum.map(&to_cards/1)
    |> Enum.concat()
  end

  def to_cards({:dream, type, count}),
    do: List.duplicate(Dream.new(type), count)

  def to_cards({:door, suit, count}),
    do: List.duplicate(Door.new(suit), count)

  def to_cards({:location, suit, symbol, count}),
    do: List.duplicate(Location.new(suit, symbol), count)

  def get_default_draw_pile do
    @default_draw_pile_input
    |> get_draw_pile()
  end
end
