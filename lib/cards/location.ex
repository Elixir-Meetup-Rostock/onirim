defmodule Cards.Location do
  defstruct type: :unknown, symbol: :unkown

  alias Cards.Location

  def get_aquarium_key, do: %Location{type: :aquarium, symbol: :key}
  def get_aquarium_moon, do: %Location{type: :aquarium, symbol: :moon}
  def get_aquarium_sun, do: %Location{type: :aquarium, symbol: :sun}

  def get_garden_key, do: %Location{type: :garden, symbol: :key}
  def get_garden_moon, do: %Location{type: :garden, symbol: :moon}
  def get_garden_sun, do: %Location{type: :garden, symbol: :sun}

  def get_library_key, do: %Location{type: :library, symbol: :key}
  def get_library_moon, do: %Location{type: :library, symbol: :moon}
  def get_library_sun, do: %Location{type: :library, symbol: :sun}

  def get_observatory_key, do: %Location{type: :observatory, symbol: :key}
  def get_observatory_moon, do: %Location{type: :observatory, symbol: :moon}
  def get_observatory_sun, do: %Location{type: :observatory, symbol: :sun}
end
