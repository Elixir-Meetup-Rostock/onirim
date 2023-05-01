defmodule Onirim.Core.Phases.Setup do
  alias Onirim.Core.Cards
  alias Onirim.Core.Cards.Door
  alias Onirim.Core.Cards.Dream
  alias Onirim.Core.Cards.Location
  alias Onirim.Core.Phases
  alias Onirim.State

  @default_draw_pile_input Application.compile_env(:onirim, :default_draw_pile)

  def default_setup do
    %State{
      draw_pile: get_default_draw_pile(),
      phase: :play_or_discard,
      status: :active
    }
    |> Cards.shuffle(:draw_pile)
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
