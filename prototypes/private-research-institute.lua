local furnaceRecipes = require("prototypes/private-research-institute-furnace-recipes")
local assemblingRecipes = require("prototypes/private-research-institute-assembling-recipes")
local building = require("prototypes/private-research-institute-building")

if settings.startup["coin_generation-private_research_institute_type"].value == "none" then
    return
end

if settings.startup["coin_generation-private_research_institute_type"].value == "per_science" then
    furnaceRecipes()
    building("furnace", "furnace", nil, 1)
elseif settings.startup["coin_generation-private_research_institute_type"].value == "grouped_science" then
    assemblingRecipes()
    building("assembling-machine", "assembling_machine", "coin_generation-private_research_institute_grouped_science", nil)
end
