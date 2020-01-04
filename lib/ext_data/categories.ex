defmodule ExtData.Categories do
  @moduledoc false

  @type parser :: :gics | :isco | :tableturn

  alias ExtData.Category
  alias ExtData.Categories.Processor

  @parsers [:gics, :isco, :tableturn]
  @parsers_impl %{gics: Processor.GICS, isco: Processor.ISCO, tableturn: Processor.Tableturn}

  @spec process_file(module, Path.t()) :: Category.t()
  def process_file(parser, path),
    do: process(parser, File.read!(path))

  @spec process(module, binary) :: Category.t()
  def process(parser, data) when parser in @parsers do
    @parsers_impl
    |> Map.get(parser)
    |> Processor.process!(data)
  end
end
