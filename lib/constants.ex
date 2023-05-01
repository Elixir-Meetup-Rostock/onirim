defmodule Constants do
  @card_types [:dream, :door, :location]
  @dream_types [:nightmare]
  @status [:victory, :defeat, :active]
  @suits [:aquarium, :garden, :library, :observatory]
  @symbols [:key, :moon, :sun]

  defmacro cards_types, do: unquote(@card_types)
  defmacro dream_types, do: unquote(@dream_types)
  defmacro status, do: unquote(@status)
  defmacro suits, do: unquote(@suits)
  defmacro symbols, do: unquote(@symbols)
end
