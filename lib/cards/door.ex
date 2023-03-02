defmodule Cards.Door do
  defstruct type: :unknown

  @types [:aquarium, :garden, :library, :observatory]

  def new(type) when type in @types do
    %__MODULE__{type: type}
  end
end
