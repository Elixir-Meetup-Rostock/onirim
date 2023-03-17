defmodule Onirim do
  # TODO Game Loop vervollständigen
  alias Phases.Setup

  def loop do
    Setup.default_setup()
    |> loop()
  end

  def loop(%State{} = state) do
    state
    |> handle_actions()
    |> victory?()
    |> defeat?()
    |> loop()
  end

  def loop(%State{status: :quit}), do: :noop

  def handle_actions(%State{} = state) do
    state
    # |> TerminalUi.basic_actions()
    |> TerminalUi.handle_phases()
  end

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
      |> Enum.filter(&Cards.location?/1)
      |> Enum.count()

    if personal_resources_count + remaining_locations_count < 5 do
      Map.put(state, :status, :defeat)
    else
      state
    end
  end
end
