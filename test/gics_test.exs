defmodule ExtData.GicsTest do
  use ExUnit.Case

  alias ExtData.Categories.Processor.GICS

  describe ".process" do
    test "invalid json" do
        ret = GICS.process("{")
        assert {:error, %Jason.DecodeError{data: "{", position: 1, token: nil}} = ret
    end

    @gics1 """
    {
      "10": {
        "name": "Energy"
      },
      "1010": {
        "name": "Energy"
      }
    }
    """
    test "category + sub-category" do
      ret = GICS.process(@gics1)
      assert {:ok,
      [
        %ExtData.Category{
          children: [
            %ExtData.Category{
              children: [],
              id: "1010",
              name: "Energy",
              readonly: false
            }
          ],
          id: "10",
          name: "Energy",
          readonly: false
        }
      ]} = ret
    end
  end
end
