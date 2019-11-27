defmodule ExtData.Categories.Processor do
  @moduledoc false

  alias ExtData.Category

  @callback process(binary) :: {:ok, [Category.t()]} | {:error, term}

  @spec process!(module, binary) :: [Category.t()]
  def process!(impl, data) do
    impl
    |> apply(:process, [data])
    |> case do
      {:ok, data} -> data
      {:error, error} -> raise ArgumentError, "parsing error: #{error}"
    end
  end

  @spec parse_json!(String.t()) :: term
  def parse_json!(filename) do
    with {:ok, body} <- File.read(filename),
         {:ok, json} <- Jason.decode(body) do
      json
    else
      _ -> raise ArgumentError, "json parsing error"
    end
  end
end
