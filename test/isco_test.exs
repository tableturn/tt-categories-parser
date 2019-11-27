defmodule ExtData.IscoTest do
  use ExUnit.Case

  alias ExtData.Categories.Processor.ISCO
  alias ExtData.Category

  describe ".process" do
    test "invalid json" do
      ret = ISCO.process("{")
      assert {:error, %Jason.DecodeError{data: "{", position: 1, token: nil}} = ret
    end

    @isco1 """
    {
      "id": "0",
      "name": "International Standard Classification of Occupations",
      "children": [
        {
          "id": "1",
          "name": "Managers",
          "children": [
            {
              "id": "11",
              "name": "Chief Executives, Senior Officials and Legislators",
              "children": [
                {
                  "id": "111",
                  "name": "Legislators and Senior Officials",
                  "children": [
                    {
                      "id": "1111",
                      "name": "Legislators"
                    }
                  ]
                }
              ]
            }
          ]
        }
      ]
    }
    """
    test "category + sub-category" do
      ret = ISCO.process(@isco1)

      assert {:ok,
              %Category{
                children: [
                  %Category{
                    children: [
                      %Category{
                        children: [
                          %Category{
                            children: [
                              %Category{
                                children: [],
                                id: "1111",
                                name: "Legislators",
                                readonly: false
                              }
                            ],
                            id: "111",
                            name: "Legislators and Senior Officials",
                            readonly: false
                          }
                        ],
                        id: "11",
                        name: "Chief Executives, Senior Officials and Legislators",
                        readonly: false
                      }
                    ],
                    id: "1",
                    name: "Managers",
                    readonly: false
                  }
                ],
                id: "0",
                name: "International Standard Classification of Occupations",
                readonly: false
              }} = ret
    end
  end
end
