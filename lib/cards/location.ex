defmodule Cards.Location do
  defstruct type: :unknown, symbol: :unkown

  @types [:aquarium, :garden, :library, :observatory]
  @symbols [:key, :moon, :sun]

  def new(type, symbol) when type in @types and symbol in @symbols do
    %__MODULE__{type: type, symbol: symbol}
  end
end
