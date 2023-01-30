defmodule Cards.Dream do
  defstruct type: :unknown

  alias Cards.Dream

  def get_nightmare, do: %Dream{type: :nightmare}
end
