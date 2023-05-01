defmodule Onirim.Core.Cards.Door do
  defstruct suit: :unknown

  require Constants

  def new(suit) when suit in Constants.suits() do
    %__MODULE__{suit: suit}
  end

  def random do
    Constants.suits()
    |> Enum.random()
    |> new()
  end
end
