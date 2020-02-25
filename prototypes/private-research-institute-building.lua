local Utils = require("utility/utils")
local Constants = require("constants")

return function(prototypType, nameType, fixedRecipe, sourceInventorySize)
    local labEntityPrototype = Utils.DeepCopy(data.raw["lab"]["lab"])
    local beaconEntity = Utils.DeepCopy(data.raw["beacon"]["beacon"])

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

    data:extend(
        {
            {
                type = "item",
                name = "coin_generation-private_research_institute_" .. nameType,
                icons = {
                    {
                        icon = Constants.AssetModName .. "/graphics/icon/private_research_institute.png",
                        icon_size = 64
                    }
                },
                subgroup = "production-machine",
                order = "g[lab]z",
                place_result = "coin_generation-private_research_institute_" .. nameType,
                stack_size = 10
            },
            {
                type = "recipe",
                name = "coin_generation-private_research_institute_" .. nameType,
                energy_required = 2,
                ingredients = {
                    {"electronic-circuit", 10},
                    {"iron-gear-wheel", 10},
                    {"transport-belt", 4}
                },
                result = "coin_generation-private_research_institute_" .. nameType,
                enabled = true
            },
            {
                type = prototypType,
                name = "coin_generation-private_research_institute_" .. nameType,
                icon = "__base__/graphics/icons/electric-furnace.png",
                icon_size = 64,
                icon_mipmaps = 4,
                localised_name = {"entity-name.coin_generation-private_research_institute"},
                localised_description = {"entity-description.coin_generation-private_research_institute"},
                flags = {"placeable-neutral", "placeable-player", "player-creation"},
                minable = {mining_time = 0.2, result = "coin_generation-private_research_institute_" .. nameType},
                max_health = 150,
                corpse = "electric-furnace-remnants",
                dying_explosion = "electric-furnace-explosion",
                collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
                selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
                damaged_trigger_effect = labEntityPrototype.damaged_trigger_effect,
                module_specification = {
                    module_slots = labEntityPrototype.module_specification.module_slots,
                    module_info_icon_shift = {0, 0.8}
                },
                allowed_effects = {"consumption", "speed", "productivity", "pollution"},
                crafting_categories = {"coin_generation-private_research_institute_" .. nameType .. "_science"},
                fixed_recipe = fixedRecipe,
                source_inventory_size = sourceInventorySize,
                result_inventory_size = 1,
                crafting_speed = 1,
                return_ingredients_on_change = true,
                energy_usage = labEntityPrototype.energy_usage,
                energy_source = labEntityPrototype.energy_source,
                vehicle_impact_sound = labEntityPrototype.vehicle_impact_sound,
                working_sound = labEntityPrototype.working_sound,
                animation = {
                    layers = {
                        beaconBase,
                        labEntityPrototype.off_animation.layers[1],
                        beaconBaseShadow
                    }
                },
                idle_animation = {
                    layers = {
                        beaconBase,
                        labEntityPrototype.off_animation.layers[1],
                        beaconBaseShadow
                    }
                },
                working_visualisations = {
                    {
                        animation = labEntityPrototype.on_animation.layers[1],
                        light = labEntityPrototype.light
                    }
                },
                water_reflection = beaconEntity.water_reflection
            }
        }
    )
    local customEntityPrototype = data.raw[prototypType]["coin_generation-private_research_institute_" .. nameType]
    for _, animation in pairs(
        {
            customEntityPrototype.animation.layers[2],
            customEntityPrototype.idle_animation.layers[2],
            customEntityPrototype.working_visualisations[1].animation
        }
    ) do
        animation.scale = 0.6
        animation.shift = {0, -0.75}
        animation.hr_version.scale = 0.3
        animation.hr_version.shift = {0, -0.75}
    end
end
