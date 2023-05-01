defmodule Utils do
  def concat_if(list, to_append, is_appended) do
    if is_appended do
      [to_append | list]
    else
      list
    end
  end
end
