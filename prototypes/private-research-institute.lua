local furnaceRecipes = require("prototypes/private-research-institute-furnace-recipes")
local assemblingRecipes = require("prototypes/private-research-institute-assembling-recipes")
local building = require("prototypes/private-research-institute-building")

local institudeType = settings.startup["coin_generation-private_research_institute_type"].value
if institudeType == "none" then
    return
end

if institudeType == "per_science" then
    furnaceRecipes()
    building("furnace", "furnace", nil, 1)
elseif institudeType == "grouped_science_non_space" or institudeType == "grouped_science_with_space" then
    assemblingRecipes(institudeType)
    building("assembling-machine", "assembling_machine", "coin_generation-private_research_institute_grouped_science", nil)
end
