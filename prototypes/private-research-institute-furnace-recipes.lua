local Utils = require("utility/utils")

return function()
    local valueDecreaseSettingRaw = settings.startup["coin_generation-private_research_institute_value_decrease_percent"].value
    local valueDecreaseSettingMultiplier = (100 - valueDecreaseSettingRaw) / 100

    data:extend(
        {
            {
                type = "recipe-category",
                name = "coin_generation-private_research_institute_furnace_science"
            }
        }
    )

    local coinItemPrototype = Utils.DeepCopy(data.raw["item"]["coin"])
    local function CreateScienceRecipe(item, coinQuantity, scienceQuantity)
        local recipeName = "coin_generation-private_research_institute_" .. item.name
        data:extend(
            {
                {
                    type = "recipe",
                    name = recipeName,
                    category = "coin_generation-private_research_institute_furnace_science",
                    localised_name = {"recipe-name.coin_generation-private_research_institute_science"},
                    localised_description = {"recipe-description.coin_generation-private_research_institute_science"},
                    energy_required = 10 * scienceQuantity,
                    ingredients = {{item.name, scienceQuantity}},
                    result = "coin",
                    result_count = coinQuantity,
                    hidden = true,
                    main_product = "",
                    icons = {
                        {
                            icon = coinItemPrototype.icon,
                            icon_size = coinItemPrototype.icon_size,
                            icon_mipmaps = coinItemPrototype.icon_mipmaps
                        },
                        {
                            icon = item.icon,
                            icon_size = item.icon_size,
                            icon_mipmaps = item.icon_mipmaps,
                            scale = 0.5
                        }
                    },
                    subgroup = "science-pack"
                }
            }
        )

        table.insert(data.raw["module"]["productivity-module"].limitation, recipeName)
        table.insert(data.raw["module"]["productivity-module-2"].limitation, recipeName)
        table.insert(data.raw["module"]["productivity-module-3"].limitation, recipeName)
    end

    --table of values for the time being - modify to be dynamic when i do the same in Prime Intergalactic Delivery mod. values taken from that mod.
    local scienceValues = {
        ["automation-science-pack"] = 1.1,
        ["logistic-science-pack"] = 2.7,
        ["military-science-pack"] = 6,
        ["chemical-science-pack"] = 10,
        ["production-science-pack"] = 33.8,
        ["utility-science-pack"] = 37.9,
        ["space-science-pack"] = 80.4
    }

    --can use data.raw["lab"]["lab"].inputs when programatically calculated
    for itemName, scienceValue in pairs(scienceValues) do
        local item = Utils.DeepCopy(data.raw["tool"][itemName])
        local scienceQuantity
        scienceValue = scienceValue * valueDecreaseSettingMultiplier
        if scienceValue >= 10 then
            scienceQuantity = 1
        elseif scienceValue >= 1 then
            scienceQuantity = Utils.RoundNumberToDecimalPlaces(5 / scienceValue, 0)
        elseif scienceValue < 1 then
            scienceQuantity = Utils.RoundNumberToDecimalPlaces(1 / scienceValue, 0)
        end
        local coinQuantity = Utils.RoundNumberToDecimalPlaces(scienceQuantity * scienceValue, 0)
        CreateScienceRecipe(item, coinQuantity, scienceQuantity)
    end
end
