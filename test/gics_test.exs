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
      "2020": {
        "name": "2.2"
      },
      "1010": {
        "name": "1.1"
      },
      "10": {
        "name": "1"
      },
      "2010": {
        "name": "2.1"
      },
      "20": {
        "name": "2"
      },
      "201010": {
        "name": "2.1.1"
      }
    }
    """
    test "category + sub-category" do
      ret = GICS.process(@gics1)

      assert {:ok,
              %ExtData.Category{
                id: "00",
                name: "GICS",
                readonly: false,
                children: [
                  %ExtData.Category{
                    id: "10",
                    name: "1",
                    readonly: false,
                    children: [
                      %ExtData.Category{
                        id: "1010",
                        name: "1.1",
                        readonly: false,
                        children: []
                      }
                    ]
                  },
                  %ExtData.Category{
                    id: "20",
                    name: "2",
                    readonly: false,
                    children: [
                      %ExtData.Category{
                        id: "2010",
                        name: "2.1",
                        readonly: false,
                        children: [
                          %ExtData.Category{
                            id: "201010",
                            name: "2.1.1",
                            readonly: false,
                            children: []
                          }
                        ]
                      },
                      %ExtData.Category{
                        id: "2020",
                        name: "2.2",
                        readonly: false,
                        children: []
                      }
                    ]
                  }
                ]
              }} = ret
    end
  end
end
