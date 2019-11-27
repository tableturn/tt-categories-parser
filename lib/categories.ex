alias Categories.Processor

defmodule Categories do
  @moduledoc false

  @spec process(:gics) :: [Category.t()]
  def process(category) when category in [:gics] do
    category
    |> case do
      :gics -> Categories.Processor.GICS
    end
    |> Processor.process!()
  end
end
