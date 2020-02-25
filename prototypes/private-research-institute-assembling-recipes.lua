local Utils = require("utility/utils")
local Constants = require("constants")

return function(institudeType)
    local valueDecreaseSettingRaw = settings.startup["coin_generation-private_research_institute_value_decrease_percent"].value
    local valueDecreaseSettingMultiplier = (100 - valueDecreaseSettingRaw) / 100

    data:extend(
        {
            {
                type = "recipe-category",
                name = "coin_generation-private_research_institute_assembling_machine_science"
            }
        }
    )

    local spaceIngredient, scienceValue, icon = nil, 172, Constants.AssetModName .. "/graphics/icon/grouped_science_non_space.png"
    if institudeType == "grouped_science_with_space" then
        spaceIngredient = {"space-science-pack", 1}
        scienceValue = 252
        icon = Constants.AssetModName .. "/graphics/icon/grouped_science_with_space.png"
    end
    data:extend(
        {
            {
                type = "recipe",
                name = "coin_generation-private_research_institute_grouped_science",
                category = "coin_generation-private_research_institute_assembling_machine_science",
                energy_required = 60,
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"military-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"production-science-pack", 1},
                    {"utility-science-pack", 1},
                    spaceIngredient
                },
                result = "coin",
                result_count = Utils.RoundNumberToDecimalPlaces(scienceValue * valueDecreaseSettingMultiplier, 0),
                hidden = true,
                main_product = "",
                icons = {
                    {
                        icon = icon,
                        icon_size = 32
                    }
                },
                subgroup = "science-pack"
            }
        }
    )

    table.insert(data.raw["module"]["productivity-module"].limitation, "coin_generation-private_research_institute_grouped_science")
    table.insert(data.raw["module"]["productivity-module-2"].limitation, "coin_generation-private_research_institute_grouped_science")
    table.insert(data.raw["module"]["productivity-module-3"].limitation, "coin_generation-private_research_institute_grouped_science")
end
