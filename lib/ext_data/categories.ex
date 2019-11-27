defmodule ExtData.Categories do
  @moduledoc false

  @type parser :: :gics

  alias ExtData.Category
  alias ExtData.Categories.Processor

  @parsers %{gics: Processor.GICS, isco: Processor.ISCO}

  @spec process(module, binary) :: [Category.t()]
  def process(parser, data) when parser in [:gics] do
    @parsers
    |> Map.get(parser)
    |> Processor.process!(data)
  end
end
