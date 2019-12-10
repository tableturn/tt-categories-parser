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
    {
      :ok,
      data
      |> Jason.decode!()
      |> Enum.reduce(%@me{id: "00", name: "GICS", children: %{}}, &parentify/2)
      |> normalize
    }
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
      |> deep_put_at(pathify(id), {id, name, desc})

  @spec deep_put_at(t, [id], {id, name, description}) :: t
  defp deep_put_at(%@me{children: children} = node, [_], {id, name, desc}) do
    child = Map.get(children, id, %@me{children: %{}})

    %@me{
      node
      | children:
          Map.put(children, id, %{
            child
            | id: id,
              name: name,
              description: desc
          })
    }
  end

  defp deep_put_at(%@me{children: children} = node, [at | rest], data) do
    child =
      children
      |> Map.get(at, %@me{children: %{}})

    %{node | children: Map.put(children, at, deep_put_at(child, rest, data))}
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

  def normalize(%@me{id: id} = node),
    do: normalize({id, node})

  def normalize({id, %{id: id, name: name, children: children}}),
    do: %Category{
      id: id,
      name: name,
      children: Enum.map(children, &normalize/1)
    }
end
