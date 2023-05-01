defmodule DreamTest do
  alias Cards.Dream

  use ExUnit.Case

  test "Create dream card (nightmare)" do
    assert Cards.Dream.new(:nightmare) == %Dream{type: :nightmare}
  end

  test "Create random dream card" do
    assert %Dream{} = Dream.random()
  end
end
