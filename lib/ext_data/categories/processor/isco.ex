defmodule ExtData.Categories.Processor.ISCO do
  @moduledoc false

  alias ExtData.Categories.Processor
  alias ExtData.Category

  @behaviour Processor

  @impl Processor
  @spec process(binary) :: {:ok, Category.t()} | {:error, term}
  def process(data) do
    {:ok,
     data
     |> Jason.decode!()
     |> normalize()}
  rescue
    e in [Jason.DecodeError] -> {:error, e}
  end

  @spec normalize(term) :: Category.t()
  def normalize(%{"id" => id, "name" => name} = node) do
    children =
      node
      |> Map.get("children", [])
      |> Enum.map(&normalize/1)

    %Category{id: id, name: name, children: children}
  end
end
