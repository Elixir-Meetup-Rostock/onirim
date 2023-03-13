defmodule Onirim do
  # TODO Game Loop vervollständigen
  def loop do
    :ok
  end

  def victory?(state = %State{}) do
    if Enum.count(state.opened_doors) === 2 do
      Map.put(state, :status, :victory)
    else
      state
    end
  end

  def defeat?(state = %State{}) do
    personal_resources_count = Enum.count(state.personal_resources)

    remaining_locations_count =
      state.draw_pile
      |> Enum.filter(&Cards.location?/1)
      |> Enum.count()

    if personal_resources_count + remaining_locations_count < 5 do
      Map.put(state, :status, :defeat)
    else
      state
    end
  end
end
