defmodule DreamTest do
  alias Onirim.Core.Cards.Dream

  use ExUnit.Case

  test "Create dream card (nightmare)" do
    assert Dream.new(:nightmare) == %Dream{type: :nightmare}
  end

  test "Create random dream card" do
    assert %Dream{} = Dream.random()
  end
end
