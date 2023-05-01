defmodule Cards.Location do
  defstruct suit: :unknown, symbol: :unkown

  require Constants

  def new(suit, symbol) when suit in Constants.suits() and symbol in Constants.symbols() do
    %__MODULE__{suit: suit, symbol: symbol}
  end

  def random do
    suit = Constants.suits() |> Enum.random()
    symbol = Constants.symbols() |> Enum.random()

    new(suit, symbol)
  end
end
