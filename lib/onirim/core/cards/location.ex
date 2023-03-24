defmodule Onirim.Core.Cards.Location do
  defstruct suit: :unknown, symbol: :unkown

  @suits Application.compile_env(:onirim, :suits)
  @symbols Application.compile_env(:onirim, :symbols)

  def new(suit, symbol) when suit in @suits and symbol in @symbols do
    %__MODULE__{suit: suit, symbol: symbol}
  end
end
