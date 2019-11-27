defmodule ExtData.Categories.Processor.ISCO do
  @moduledoc false

  alias ExtData.Categories.Processor
  alias ExtData.Category

  @behaviour Processor

  @impl Processor
  @spec process(binary) :: {:ok, [Category.t()]} | {:error, term}
  def process(data) do
    data
    |> Jason.decode!()
    |> parse()
    |> (&{:ok, &1}).()
  rescue
    e in [Jason.DecodeError] ->
      {:error, e}
  end

  defp parse(%{"id" => id, "name" => name} = cat) do
    children =
      cat
      |> Map.get("children", [])
      |> Enum.map(&parse/1)

    %Category{id: id, name: name, children: children}
  end
end
