defmodule ExtData.Categories do
  @moduledoc false

  @type parser :: :gics | :isco | :tableturn

  alias ExtData.Category
  alias ExtData.Categories.Processor

  @parsers %{gics: Processor.GICS, isco: Processor.ISCO, tableturn: Processor.Tableturn}

  @spec process_file(module, Path.t) :: [Category.t]
  def process_file(parser, path) do
    data = File.read!(path)
    process(parser, data)
  end

  @spec process(module, binary) :: [Category.t()]
  def process(parser, data) when parser in [:gics] do
    @parsers
    |> Map.get(parser)
    |> Processor.process!(data)
  end
end
