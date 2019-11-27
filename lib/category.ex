defmodule Category do
  @moduledoc false

  @type t :: %__MODULE__{
          id: String.t() | nil,
          name: String.t() | nil,
          readonly: :boolean,
          children: [t]
        }
  defstruct [:id, :name, :readonly, :children]
end
