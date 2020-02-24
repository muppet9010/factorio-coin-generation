local furnaceRecipes = require("prototypes/private-research-institute-furnace-recipes")
local furnaceBuilding = require("prototypes/private-research-institute-furnace-building")
local Constants = require("constants")

local valueDecreaseSettingRaw = settings.startup["coin_generation-private_research_institute_value_decrease_percent"].value
if valueDecreaseSettingRaw < 0 or valueDecreaseSettingRaw >= 100 then
    return
end

local valueDecreaseSettingMultiplier = (100 - valueDecreaseSettingRaw) / 100
local scienceQuantityPerAction = 10

local beaconBase = {
    filename = Constants.AssetModName .. "/graphics/entity/private_research_institiute_beacon_base.png",
    width = 148,
    height = 93,
    shift = {0.85, 0.046875}
}
local beaconBaseShadow = {
    filename = Constants.AssetModName .. "/graphics/entity/private_research_institiute_beacon_base_shadow.png",
    width = 148,
    height = 93,
    shift = {0.85, 0.046875},
    frame_count = 1,
    draw_as_shadow = true
}

furnaceRecipes(scienceQuantityPerAction, valueDecreaseSettingMultiplier)
furnaceBuilding(beaconBase, beaconBaseShadow)
