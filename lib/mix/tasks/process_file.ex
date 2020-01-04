defmodule Mix.Tasks.Categories.ProcessFile do
  use Mix.Task
  alias ExtData.{Category, Categories}

  @shortdoc """
  Run the Categories.process_file/2 function with given parser module and file.
  """
  @impl Mix.Task
  def run(args),
    do:
      args
      |> OptionParser.parse(strict: [parser: :string])
      |> run_with_parsed_options

  defp run_with_parsed_options({[parser: parser], [filename], []}),
    do:
      parser
      |> String.to_atom()
      |> Categories.process_file(filename)
end
