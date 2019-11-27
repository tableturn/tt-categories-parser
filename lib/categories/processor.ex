defmodule Categories.Processor do
  @moduledoc false

  @callback process() :: {:ok, [Category.t()]} | {:error, String.t()}

  @spec process!(any) :: [Category.t()]
  def process!(impl) do
    impl.process
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
