defmodule ExtData.Category do
  @moduledoc """
  Describe business category
  """
  @derive Jason.Encoder

  @type t :: %__MODULE__{
          id: String.t() | nil,
          name: String.t() | nil,
          readonly: boolean(),
          children: [t]
        }

  defstruct id: nil,
            name: nil,
            readonly: false,
            children: []
end
