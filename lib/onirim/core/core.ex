defmodule Onirim.Core do
  alias Onirim.State
  alias Onirim.Core.Cards

  def victory?(%State{} = state) do
    if Enum.count(state.opened_doors) === 8 do
      Map.put(state, :status, :victory)
    else
      state
    end
  end

  def defeat?(%State{} = state) do
    personal_resources_count = Enum.count(state.personal_resources)

    remaining_locations_count =
      state.draw_pile
      |> Enum.count(&Cards.location?/1)

    if personal_resources_count + remaining_locations_count < 5 do
      Map.put(state, :status, :defeat)
    else
      state
    end
  end
end
