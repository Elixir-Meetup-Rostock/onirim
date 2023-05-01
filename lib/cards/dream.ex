defmodule Cards.Dream do
  defstruct type: :unknown

  require Constants

  def new(type) when type in Constants.dream_types() do
    %__MODULE__{type: type}
  end

  def random do
    Constants.dream_types()
    |> Enum.random()
    |> new()
  end
end
