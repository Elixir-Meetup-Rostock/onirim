defmodule Onirim.Core.Cards.Dream do
  defstruct type: :unknown

  @types [:nightmare]

  def new(type) when type in @types do
    %__MODULE__{type: type}
  end
end
