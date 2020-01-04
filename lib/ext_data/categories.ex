defmodule ExtData.Categories do
  @moduledoc false

  alias ExtData.{Category, Categories.Processor}

  @type parser :: :gics | :isco | :tableturn

  @parsers [:gics, :isco, :tableturn]
  @parsers_impl %{
    gics: Processor.GICS,
    isco: Processor.ISCO,
    tableturn: Processor.Tableturn
  }

  @spec process_file(parser, String.t()) :: Category.t()
  def process_file(parser, path),
    do: parser |> process(File.read!(path))

  @spec process(module, binary) :: Category.t()
  def process(parser, data) when parser in @parsers do
    @parsers_impl
    |> Map.get(parser)
    |> Processor.process!(data)
  end
end
