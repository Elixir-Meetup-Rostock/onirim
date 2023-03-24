defmodule Onirim.Core.Cards.Door do
  defstruct suit: :unknown

  @suits Application.compile_env(:onirim, :suits)

  def new(suit) when suit in @suits do
    %__MODULE__{suit: suit}
  end
end
