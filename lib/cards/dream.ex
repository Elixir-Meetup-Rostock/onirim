defmodule Cards.Dream do
  defstruct type: :aquarium

  alias Cards.Dream

  def get_nightmare, do: %Dream{type: :nightmare}
end
