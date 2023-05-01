defmodule CardsTest do
  use ExUnit.Case

  test "Add multiple cards and check count" do
    cards = get_random_pile(20)

    cards_added = Cards.add_cards(cards, Cards.Door.random(), 5)

    assert Enum.count(cards_added) === 25
  end

  test "Add Card and check first card" do
    cards = get_random_pile(20)

    cards_added = Cards.add_cards(cards, Cards.Door.new(:garden))

    assert List.first(cards_added) === Cards.Door.new(:garden)
  end

  test "Add card to pile" do
    result =
      %State{}
      |> Cards.add(:draw_pile, Cards.Dream.new(:nightmare))
      |> Cards.has(:draw_pile, Cards.Dream.new(:nightmare))

    assert true == result
  end

  test "Add card to pile and check position" do
    result =
      %State{}
      |> Cards.add(:draw_pile, Cards.Dream.new(:nightmare))
      |> Map.get(:draw_pile)
      |> List.first()

    assert Cards.Dream.new(:nightmare) == result
  end

  test "Has card in pile" do
    state = %State{draw_pile: [Cards.Dream.new(:nightmare)]}

    result =
      state
      |> Map.get(:draw_pile)
      |> Enum.member?(Cards.Dream.new(:nightmare))

    assert true == result
  end

  test "Shuffle draw pile" do
    {original_pile, shuffled_pile} = get_original_and_shuffled_pile(:draw_pile, 1000)

    refute original_pile == shuffled_pile
  end

  test "Shuffle discard pile" do
    {original_pile, shuffled_pile} = get_original_and_shuffled_pile(:discard_pile, 1000)

    refute original_pile == shuffled_pile
  end

  test "Shuffle personal resources" do
    {original_pile, shuffled_pile} = get_original_and_shuffled_pile(:personal_resources, 1000)

    refute original_pile == shuffled_pile
  end

  # TODO Weniger Heisentestig
  def get_random_pile(count) do
    for _ <- 1..count, do: Cards.random()
  end

  def get_original_and_shuffled_pile(pile, count) do
    random_pile = get_random_pile(count)
    state = %State{} |> Map.put(pile, random_pile)

    original_pile =
      state
      |> Map.get(pile)

    shuffled_pile =
      state
      |> Cards.shuffle(pile)
      |> Map.get(pile)

    {original_pile, shuffled_pile}
  end
end
