defmodule Cards do
  alias Cards.Door
  alias Cards.Dream
  alias Cards.Location

  # TODO Map.update anstatt Map.put

  def add_cards(cards, card, count \\ 1)
  def add_cards(cards, card, 1), do: [card | cards]
  def add_cards(cards, card, count), do: add_cards([card | cards], card, count - 1)

  def add(%State{} = state, pile, card) do
    card_pile = [card | state |> Map.get(pile)]

    Map.put(state, pile, card_pile)
  end

  def has(%State{} = state, pile, card) do
    state
    |> Map.get(pile)
    |> Enum.find_index(&(&1 = card))
    |> is_integer()
  end

  def move(%State{} = state, from_pile, to_pile) do
    new_to_pile = Map.get(state, from_pile) ++ Map.get(state, to_pile)

    state
    |> Map.put(to_pile, new_to_pile)
    |> Map.put(from_pile, [])
  end

  def move(%State{} = state, from_pile, to_pile, card) do
    state
    |> remove(from_pile, card)
    |> add(to_pile, card)
  end

  def move_drawn_card(%State{} = state, to_pile) do
    state
    |> add(to_pile, state.drawn_card)
    |> Map.put(:drawn_card, nil)
  end

  def remove(%State{} = state, pile, card) do
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

  def move_top_card(%State{} = state, from_pile, to_pile) do
    card_pile = Map.get(state, from_pile)

    top_card =
      card_pile
      |> List.first()

    state
    |> Cards.add(to_pile, top_card)
    |> Map.put(from_pile, card_pile |> tl())
  end

  def shuffle(%State{} = state, pile) do
    Map.update!(state, pile, &Enum.shuffle/1)
  end

  def location?(%Location{}), do: true
  def location?(_), do: false

  def dream?(%Dream{}), do: true
  def dream?(_), do: false

  def door?(%Door{}), do: true
  def door?(_), do: false
end
