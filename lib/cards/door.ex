defmodule Cards.Door do
  defstruct type: :aquarium

  alias Cards.Door

  def get_aquarium_door, do: %Door{type: :aquarium}
  def get_garden_door, do: %Door{type: :garden}
  def get_library_door, do: %Door{type: :library}
  def get_observatory_door, do: %Door{type: :observatory}
end
