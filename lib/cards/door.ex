defmodule Cards.Door do
  defstruct type: :unknown

  @types [:aquarium, :garden, :library, :observatory]

  def new(type) when type in @types do
    %__MODULE__{type: type}
  end

  def get_aquarium_door, do: %__MODULE__{type: :aquarium}
  def get_garden_door, do: %__MODULE__{type: :garden}
  def get_library_door, do: %__MODULE__{type: :library}
  def get_observatory_door, do: %__MODULE__{type: :observatory}
end
