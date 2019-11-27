defmodule ExtData.Categories.Processor.Tableturn do
  @moduledoc false

  alias ExtData.Categories.Processor
  alias ExtData.Category

  @behaviour Processor

  @impl Processor
  @spec process(binary) :: {:ok, [Category.t()]} | {:error, term}
  def process(data) do
    data
    |> Jason.decode!()
    |> Enum.map(&parse/1)
    |> (&{:ok, %Category{id: "Industries", children: &1}}).()
  rescue
    e in [Jason.DecodeError] ->
      {:error, e}
  end

  defp parse(map, parent_name \\ nil) do
    name = Map.fetch!(map, "name")
    id = build_id(parent_name, name)

    %Category{
      id: id,
      name: Map.fetch!(map, "name"),
      readonly: Map.get(map, "readonly", false),
      children: map |> Map.get("children", []) |> Enum.map(fn child -> parse(child, id) end)
    }
  end

  defp build_id(nil, name), do: name
  defp build_id(parent_name, name), do: parent_name <> ">" <> name
end
