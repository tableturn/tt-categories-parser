defmodule ExtData.Categories.Processor.GICS do
  @moduledoc false

  alias ExtData.Categories.Processor
  alias ExtData.Category

  @behaviour Processor
  @me __MODULE__

  @typep id :: String.t()
  @typep name :: String.t()
  @typep description :: String.t() | nil
  @typep children :: %{id => t}

  @typep json_item :: %{String.t() => %{}}

  @typep t :: %__MODULE__{
           id: id,
           name: name,
           description: description,
           children: children
         }
  defstruct [:id, :name, :description, :children]

  @impl Processor
  @spec process(binary) :: {:ok, Category.t()} | {:error, term}
  def process(data) do
    children =
      data
      |> Jason.decode!()
      |> Enum.reduce(%@me{children: %{}}, &parentify/2)
      |> Map.get(:children)
      |> normalize()

    {:ok, %Category{name: "GICS", children: children}}
  rescue
    e in [Jason.DecodeError] -> {:error, e}
  end

  @spec parentify({id, json_item}, t) :: t
  defp parentify({id, %{"name" => name, "description" => desc}}, root),
    do: do_parentify(id, name, desc, root)

  defp parentify({id, %{"name" => name}}, root),
    do: do_parentify(id, name, nil, root)

  @spec do_parentify(id, name, description, t) :: t
  defp do_parentify(id, name, desc, root),
    do:
      root
      |> deep_put_at(pathify(id), {name, desc})

  @spec deep_put_at(t, [id], {name, description}) :: t
  defp deep_put_at(%@me{} = node, [at], {name, desc}) do
    child = %@me{name: name, description: desc, children: %{}}
    %@me{node | id: at, name: name, children: Map.put(node.children, at, child)}
  end

  defp deep_put_at(%@me{} = node, [at | rest], data) do
    child =
      node
      |> Map.get(:children)
      |> Map.get(at, %@me{children: %{}})

    children =
      node
      |> Map.get(:children)
      |> Map.put(at, deep_put_at(child, rest, data))

    %{node | children: children}
  end

  @spec pathify(String.t(), [String.t()]) :: [String.t()]
  defp pathify(id, path \\ []) do
    id
    |> String.length()
    |> case do
      0 -> path
      x -> id |> String.slice(0, x - 2) |> pathify([id] ++ path)
    end
  end

  @spec normalize({String.t(), %{id => t}}) :: [Category.t()]
  defp normalize(nodes),
    do:
      nodes
      |> Enum.map(fn {id, %{name: name, children: children}} ->
        %Category{id: id, name: name, children: normalize(children)}
      end)
end
