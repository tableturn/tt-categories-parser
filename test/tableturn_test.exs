defmodule ExtData.TableturnTest do
  use ExUnit.Case

  alias ExtData.Categories.Processor.Tableturn
  alias ExtData.Category

  describe ".process" do
    test "invalid json" do
      ret = Tableturn.process("{")
      assert {:error, %Jason.DecodeError{data: "{", position: 1, token: nil}} = ret
    end

    @tableturn1 """
    [
      {
          "name": "BioTech",
          "readonly": true,
          "children": [
              { "name": "Nutrient Supplementation" },
              { "name": "Abiotic Stress Resistance" },
              { "name": "Industrial Biotech" },
              { "name": "Strength Fibers" },
              { "name": "Biofuels" },
              { "name": "Healthcare" }
          ]
      },
      {
          "name": "FinTech",
          "readonly": true,
          "children": [
              { "name": "Investment Management" },
              { "name": "Banking" },
              { "name": "Financial Advisory" }
          ]
      },
      {
          "name": "RegTech",
          "readonly": true,
          "children": [
              { "name": "Transaction Monitoring" },
              { "name": "Horizon Scanning" },
              { "name": "Case Management Tools" },
              { "name": "Reporting and Compliance" },
              { "name": "Regulatory Monitoring and Compliance" },
              { "name": "Accounting and Electronic Discovery" },
              { "name": "Identify Verification" }
          ]
      },
      {
          "name": "FoodTech",
          "readonly": true,
          "children": [
              { "name": "Food Microbiology" },
              { "name": "Food Engineering and Processing" },
              { "name": "Food Chemistry" },
              { "name": "Nutrition" },
              { "name": "Sensory Analysis" }
          ]
      },
      {
          "name": "HealthTech",
          "readonly": true,
          "children": [
              { "name": "Biopharmaceutical" },
              { "name": "Advanced medical therapy" },
              { "name": "Medical devices" },
              {
                  "name": "Medical imaging",
                  "children": [
                      { "name": "Diagnostics" },
                      { "name": "Research equipment" },
                      { "name": "Nutraceuticals / Functional food" },
                      { "name": "Drug delivery" }
                  ]
              }
          ]
      },
      {
          "name": "Energy (BlueTech/ GreenTech)",
          "readonly": true,
          "children": [
              {
                  "name": "Alternative / Clean Power ",
                  "children": [{ "name": "Solar" }, { "name": "Wind" }, { "name": "Hydro" }]
              },
              { "name": "Water Recycling / Purification" },
              { "name": "Air Purification" },
              { "name": "Sewage Treatment" },
              { "name": "Solid Waste Management" },
              { "name": "Energy Conservation" }
          ]
      },
      {
          "name": "AgriTech",
          "readonly": true,
          "children": [
              { "name": "Weather Tracking" },
              { "name": "Irrigation" },
              { "name": "Light / Heat Control" },
              { "name": "Disease Prediction" },
              { "name": "Soil Management" }
          ]
      }
    ]
    """
    test "category + sub-category" do
      ret = Tableturn.process(@tableturn1)

      assert {:ok,
              %Category{
                children: [
                  %Category{
                    children: [
                      %Category{
                        children: [],
                        id: "BioTech>Nutrient Supplementation",
                        name: "Nutrient Supplementation",
                        readonly: false
                      },
                      %Category{
                        children: [],
                        id: "BioTech>Abiotic Stress Resistance",
                        name: "Abiotic Stress Resistance",
                        readonly: false
                      },
                      %Category{
                        children: [],
                        id: "BioTech>Industrial Biotech",
                        name: "Industrial Biotech",
                        readonly: false
                      },
                      %Category{
                        children: [],
                        id: "BioTech>Strength Fibers",
                        name: "Strength Fibers",
                        readonly: false
                      },
                      %Category{
                        children: [],
                        id: "BioTech>Biofuels",
                        name: "Biofuels",
                        readonly: false
                      },
                      %Category{
                        children: [],
                        id: "BioTech>Healthcare",
                        name: "Healthcare",
                        readonly: false
                      }
                    ],
                    id: "BioTech",
                    name: "BioTech",
                    readonly: true
                  },
                  %Category{
                    children: [
                      %Category{
                        children: [],
                        id: "FinTech>Investment Management",
                        name: "Investment Management",
                        readonly: false
                      },
                      %Category{
                        children: [],
                        id: "FinTech>Banking",
                        name: "Banking",
                        readonly: false
                      },
                      %Category{
                        children: [],
                        id: "FinTech>Financial Advisory",
                        name: "Financial Advisory",
                        readonly: false
                      }
                    ],
                    id: "FinTech",
                    name: "FinTech",
                    readonly: true
                  },
                  %Category{
                    children: [
                      %Category{
                        children: [],
                        id: "RegTech>Transaction Monitoring",
                        name: "Transaction Monitoring",
                        readonly: false
                      },
                      %Category{
                        children: [],
                        id: "RegTech>Horizon Scanning",
                        name: "Horizon Scanning",
                        readonly: false
                      },
                      %Category{
                        children: [],
                        id: "RegTech>Case Management Tools",
                        name: "Case Management Tools",
                        readonly: false
                      },
                      %Category{
                        children: [],
                        id: "RegTech>Reporting and Compliance",
                        name: "Reporting and Compliance",
                        readonly: false
                      },
                      %Category{
                        children: [],
                        id: "RegTech>Regulatory Monitoring and Compliance",
                        name: "Regulatory Monitoring and Compliance",
                        readonly: false
                      },
                      %Category{
                        children: [],
                        id: "RegTech>Accounting and Electronic Discovery",
                        name: "Accounting and Electronic Discovery",
                        readonly: false
                      },
                      %Category{
                        children: [],
                        id: "RegTech>Identify Verification",
                        name: "Identify Verification",
                        readonly: false
                      }
                    ],
                    id: "RegTech",
                    name: "RegTech",
                    readonly: true
                  },
                  %Category{
                    children: [
                      %Category{
                        children: [],
                        id: "FoodTech>Food Microbiology",
                        name: "Food Microbiology",
                        readonly: false
                      },
                      %Category{
                        children: [],
                        id: "FoodTech>Food Engineering and Processing",
                        name: "Food Engineering and Processing",
                        readonly: false
                      },
                      %Category{
                        children: [],
                        id: "FoodTech>Food Chemistry",
                        name: "Food Chemistry",
                        readonly: false
                      },
                      %Category{
                        children: [],
                        id: "FoodTech>Nutrition",
                        name: "Nutrition",
                        readonly: false
                      },
                      %Category{
                        children: [],
                        id: "FoodTech>Sensory Analysis",
                        name: "Sensory Analysis",
                        readonly: false
                      }
                    ],
                    id: "FoodTech",
                    name: "FoodTech",
                    readonly: true
                  },
                  %Category{
                    children: [
                      %Category{
                        children: [],
                        id: "HealthTech>Biopharmaceutical",
                        name: "Biopharmaceutical",
                        readonly: false
                      },
                      %Category{
                        children: [],
                        id: "HealthTech>Advanced medical therapy",
                        name: "Advanced medical therapy",
                        readonly: false
                      },
                      %Category{
                        children: [],
                        id: "HealthTech>Medical devices",
                        name: "Medical devices",
                        readonly: false
                      },
                      %Category{
                        children: [
                          %Category{
                            children: [],
                            id: "HealthTech>Medical imaging>Diagnostics",
                            name: "Diagnostics",
                            readonly: false
                          },
                          %Category{
                            children: [],
                            id: "HealthTech>Medical imaging>Research equipment",
                            name: "Research equipment",
                            readonly: false
                          },
                          %Category{
                            children: [],
                            id: "HealthTech>Medical imaging>Nutraceuticals / Functional food",
                            name: "Nutraceuticals / Functional food",
                            readonly: false
                          },
                          %Category{
                            children: [],
                            id: "HealthTech>Medical imaging>Drug delivery",
                            name: "Drug delivery",
                            readonly: false
                          }
                        ],
                        id: "HealthTech>Medical imaging",
                        name: "Medical imaging",
                        readonly: false
                      }
                    ],
                    id: "HealthTech",
                    name: "HealthTech",
                    readonly: true
                  },
                  %Category{
                    children: [
                      %Category{
                        children: [
                          %Category{
                            children: [],
                            id: "Energy (BlueTech/ GreenTech)>Alternative / Clean Power >Solar",
                            name: "Solar",
                            readonly: false
                          },
                          %Category{
                            children: [],
                            id: "Energy (BlueTech/ GreenTech)>Alternative / Clean Power >Wind",
                            name: "Wind",
                            readonly: false
                          },
                          %Category{
                            children: [],
                            id: "Energy (BlueTech/ GreenTech)>Alternative / Clean Power >Hydro",
                            name: "Hydro",
                            readonly: false
                          }
                        ],
                        id: "Energy (BlueTech/ GreenTech)>Alternative / Clean Power ",
                        name: "Alternative / Clean Power ",
                        readonly: false
                      },
                      %Category{
                        children: [],
                        id: "Energy (BlueTech/ GreenTech)>Water Recycling / Purification",
                        name: "Water Recycling / Purification",
                        readonly: false
                      },
                      %Category{
                        children: [],
                        id: "Energy (BlueTech/ GreenTech)>Air Purification",
                        name: "Air Purification",
                        readonly: false
                      },
                      %Category{
                        children: [],
                        id: "Energy (BlueTech/ GreenTech)>Sewage Treatment",
                        name: "Sewage Treatment",
                        readonly: false
                      },
                      %Category{
                        children: [],
                        id: "Energy (BlueTech/ GreenTech)>Solid Waste Management",
                        name: "Solid Waste Management",
                        readonly: false
                      },
                      %Category{
                        children: [],
                        id: "Energy (BlueTech/ GreenTech)>Energy Conservation",
                        name: "Energy Conservation",
                        readonly: false
                      }
                    ],
                    id: "Energy (BlueTech/ GreenTech)",
                    name: "Energy (BlueTech/ GreenTech)",
                    readonly: true
                  },
                  %Category{
                    children: [
                      %Category{
                        children: [],
                        id: "AgriTech>Weather Tracking",
                        name: "Weather Tracking",
                        readonly: false
                      },
                      %Category{
                        children: [],
                        id: "AgriTech>Irrigation",
                        name: "Irrigation",
                        readonly: false
                      },
                      %Category{
                        children: [],
                        id: "AgriTech>Light / Heat Control",
                        name: "Light / Heat Control",
                        readonly: false
                      },
                      %Category{
                        children: [],
                        id: "AgriTech>Disease Prediction",
                        name: "Disease Prediction",
                        readonly: false
                      },
                      %Category{
                        children: [],
                        id: "AgriTech>Soil Management",
                        name: "Soil Management",
                        readonly: false
                      }
                    ],
                    id: "AgriTech",
                    name: "AgriTech",
                    readonly: true
                  }
                ],
                id: "Industries",
                name: nil,
                readonly: false
              }} = ret
    end
  end
end
