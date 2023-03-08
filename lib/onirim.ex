defmodule Onirim do
  alias Game

  def hello do
    :world
  end

  def game_loop do
    state = Game.setup()
  end

  def get_actions(%State{phase: phase}) do
    IO.puts("Available Actions:")

    case phase do
      :setup ->
        IO.puts("- setup")

      :play_or_discard ->
        IO.puts("- discard card")
        IO.puts("- play card")

      :refill_hand ->
        IO.puts("- draw card")

      :shuffle_limbo ->
        IO.puts("- shuffle limbo")

      _ ->
        :ok
    end

    IO.puts("")
  end

  def check_status(state = %State{}) do
  end
end
