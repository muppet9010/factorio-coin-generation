local Utils = require("utility/utils")

return function(beaconBase, beaconBaseShadow)
    local labEntityPrototype = Utils.DeepCopy(data.raw["lab"]["lab"])
    local beaconEntity = Utils.DeepCopy(data.raw["beacon"]["beacon"])

    data:extend(
        {
            {
                type = "item",
                name = "coin_generation-private_research_institute_smelter",
                icon = "__base__/graphics/icons/electric-furnace.png",
                icon_size = 64,
                icon_mipmaps = 4,
                subgroup = "production-machine",
                order = "g[lab]z",
                place_result = "coin_generation-private_research_institute_smelter",
                stack_size = 10
            },
            {
                type = "furnace",
                name = "coin_generation-private_research_institute_smelter",
                icon = "__base__/graphics/icons/electric-furnace.png",
                icon_size = 64,
                icon_mipmaps = 4,
                flags = {"placeable-neutral", "placeable-player", "player-creation"},
                minable = {mining_time = 0.2, result = "coin_generation-private_research_institute_smelter"},
                max_health = 350,
                corpse = "electric-furnace-remnants",
                dying_explosion = "electric-furnace-explosion",
                resistances = {
                    {
                        type = "fire",
                        percent = 80
                    }
                },
                collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
                selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
                damaged_trigger_effect = labEntityPrototype.damaged_trigger_effect,
                module_specification = {
                    module_slots = labEntityPrototype.module_specification.module_slots,
                    module_info_icon_shift = {0, 0.8} --TODO: CHANGE ME
                },
                allowed_effects = {"consumption", "speed", "productivity", "pollution"},
                crafting_categories = {"coin_generation-private_research_institute_smelting_science"},
                result_inventory_size = 1,
                crafting_speed = 1,
                energy_usage = labEntityPrototype.energy_usage,
                source_inventory_size = 1,
                energy_source = labEntityPrototype.energy_source,
                vehicle_impact_sound = labEntityPrototype.vehicle_impact_sound,
                working_sound = labEntityPrototype.working_sound,
                animation = {
                    layers = {
                        beaconBase,
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
    local customFurnaceEntityPrototype = data.raw["furnace"]["coin_generation-private_research_institute_smelter"]
    for _, animation in pairs(
        {
            customFurnaceEntityPrototype.idle_animation.layers[2],
            customFurnaceEntityPrototype.idle_animation.layers[2].hr_version,
            customFurnaceEntityPrototype.working_visualisations[1].animation,
            customFurnaceEntityPrototype.working_visualisations[1].animation.hr_version
        }
    ) do
        animation.scale = 0.6
        animation.shift = {0, -0.75}
    end
end
