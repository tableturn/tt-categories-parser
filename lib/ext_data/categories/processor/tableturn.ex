defmodule ExtData.Categories.Processor.Tableturn do
  @moduledoc false

  alias ExtData.Categories.Processor
  alias ExtData.Category

  @behaviour Processor

  @impl Processor
  def process(data) do
    data
    |> Jason.decode!()
    |> Enum.map(&parse/1)
    |> (&{:ok, %Category{id: "Industries", name: nil, readonly: false, children: &1}}).()
  rescue
    e in [Jason.DecodeError] ->
      {:error, e}
  end

  @spec parse(map, String.t() | nil) :: Category.t()
  defp parse(map, parent_name \\ nil) do
    name = Map.fetch!(map, "name")
    id = build_id(parent_name, name)

    %Category{
      id: id,
      name: "#{Map.fetch!(map, "name")}",
      readonly: Map.get(map, "readonly") || false,
      children:
        map
        |> Map.get("children", [])
        |> Enum.map(&parse(&1, id))
    }
  end

  @spec build_id(String.t() | nil, String.t()) :: String.t()
  defp build_id(nil, name), do: name
  defp build_id(parent_name, name), do: "#{parent_name}>#{name}"
end
