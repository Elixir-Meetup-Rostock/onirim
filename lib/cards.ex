defmodule Cards do
  def add_cards(cards, card, count \\ 1)
  def add_cards(cards, card, 1), do: [card | cards]
  def add_cards(cards, card, count), do: add_cards([card | cards], card, count - 1)

  def add(state = %State{}, pile, card) do
    card_pile = [card | state |> Map.get(pile)]

    Map.put(state, pile, card_pile)
  end

  def has(state = %State{}, pile, card) do
    state
    |> Map.get(pile)
    |> Enum.find_index(&(&1 = card))
    |> is_integer()
  end

  def move(state = %State{}, from_pile, to_pile, card) do
    state
    |> remove(from_pile, card)
    |> add(to_pile, card)
  end

  def remove(state = %State{}, pile, card) do
    index =
      state
      |> Map.get(pile)
      |> Enum.find_index(&(&1 = card))

    card_pile =
      state
      |> Map.get(pile)
      |> List.delete_at(index)

    state
    |> Map.put(pile, card_pile)
  end

  def shuffle(state = %State{}, pile) do
    shuffled_pile =
      Map.get(state, pile)
      |> Enum.shuffle()

    Map.put(state, pile, shuffled_pile)
  end
end