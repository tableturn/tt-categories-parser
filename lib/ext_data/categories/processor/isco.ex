defmodule ExtData.Categories.Processor.ISCO do
  @moduledoc false

  alias ExtData.Categories.Processor
  alias ExtData.Category

  @behaviour Processor

  @impl Processor
  def process(data) do
    {:ok,
     data
     |> Jason.decode!()
     |> normalize()}
  rescue
    e in [Jason.DecodeError] -> {:error, e}
  end

  @typep json_attrs :: %{id: String.t(), name: String.t(), children: [json_attrs]}
  @spec normalize(json_attrs) :: Category.t()
  defp normalize(%{"id" => id, "name" => name, "children" => children})
       when is_binary(id) and is_binary(name) and is_list(children),
       do: %Category{
         id: id,
         name: name,
         readonly: false,
         children: Enum.map(children, &normalize/1)
       }
end
