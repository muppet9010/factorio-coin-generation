local valueDecreaseSettingRaw = settings.startup["coin_generation-private_research_institute_value_decrease_percent"].value
if valueDecreaseSettingRaw < 0 or valueDecreaseSettingRaw >= 100 then
    return
end
local valueDecreaseSettingMultiplier = (100 - valueDecreaseSettingRaw) / 100
local scienceQuantityPerAction = 10

data:extend(
    {
        {
            type = "recipe-category",
            name = "coin_generation-private_research_institute_smelting_science"
        }
    }
)

local coinItemPrototype = data.raw["item"]["coin"]
local function CreateScienceRecipe(item, coinValue)
    data:extend(
        {
            {
                type = "recipe",
                name = "coin_generation-private_research_institute_" .. item.name,
                category = "coin_generation-private_research_institute_smelting_science",
                energy_required = 5 * scienceQuantityPerAction,
                ingredients = {{item.name, scienceQuantityPerAction}},
                result = "coin",
                result_count = (coinValue * scienceQuantityPerAction) * valueDecreaseSettingMultiplier,
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

local labEntityPrototype = data.raw["lab"]["lab"]
for _, itemName in pairs(labEntityPrototype.inputs) do
    local item = data.raw["tool"][itemName]
    CreateScienceRecipe(item, scienceValues[itemName])
end

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
                module_slots = 2,
                module_info_icon_shift = {0, 0.8}
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
                    {
                        filename = "__base__/graphics/entity/electric-furnace/electric-furnace-base.png",
                        priority = "high",
                        width = 129,
                        height = 100,
                        frame_count = 1,
                        shift = {0.421875, 0},
                        hr_version = {
                            filename = "__base__/graphics/entity/electric-furnace/hr-electric-furnace.png",
                            priority = "high",
                            width = 239,
                            height = 219,
                            frame_count = 1,
                            shift = util.by_pixel(0.75, 5.75),
                            scale = 0.5
                        }
                    },
                    {
                        filename = "__base__/graphics/entity/electric-furnace/electric-furnace-shadow.png",
                        priority = "high",
                        width = 129,
                        height = 100,
                        frame_count = 1,
                        shift = {0.421875, 0},
                        draw_as_shadow = true,
                        hr_version = {
                            filename = "__base__/graphics/entity/electric-furnace/hr-electric-furnace-shadow.png",
                            priority = "high",
                            width = 227,
                            height = 171,
                            frame_count = 1,
                            draw_as_shadow = true,
                            shift = util.by_pixel(11.25, 7.75),
                            scale = 0.5
                        }
                    }
                }
            },
            working_visualisations = {
                {
                    animation = {
                        filename = "__base__/graphics/entity/electric-furnace/electric-furnace-heater.png",
                        priority = "high",
                        width = 25,
                        height = 15,
                        frame_count = 12,
                        animation_speed = 0.5,
                        shift = {0.015625, 0.890625},
                        hr_version = {
                            filename = "__base__/graphics/entity/electric-furnace/hr-electric-furnace-heater.png",
                            priority = "high",
                            width = 60,
                            height = 56,
                            frame_count = 12,
                            animation_speed = 0.5,
                            shift = util.by_pixel(1.75, 32.75),
                            scale = 0.5
                        }
                    },
                    light = {intensity = 0.4, size = 6, shift = {0.0, 1.0}, color = {r = 1.0, g = 1.0, b = 1.0}}
                },
                {
                    animation = {
                        filename = "__base__/graphics/entity/electric-furnace/electric-furnace-propeller-1.png",
                        priority = "high",
                        width = 19,
                        height = 13,
                        frame_count = 4,
                        animation_speed = 0.5,
                        shift = {-0.671875, -0.640625},
                        hr_version = {
                            filename = "__base__/graphics/entity/electric-furnace/hr-electric-furnace-propeller-1.png",
                            priority = "high",
                            width = 37,
                            height = 25,
                            frame_count = 4,
                            animation_speed = 0.5,
                            shift = util.by_pixel(-20.5, -18.5),
                            scale = 0.5
                        }
                    }
                },
                {
                    animation = {
                        filename = "__base__/graphics/entity/electric-furnace/electric-furnace-propeller-2.png",
                        priority = "high",
                        width = 12,
                        height = 9,
                        frame_count = 4,
                        animation_speed = 0.5,
                        shift = {0.0625, -1.234375},
                        hr_version = {
                            filename = "__base__/graphics/entity/electric-furnace/hr-electric-furnace-propeller-2.png",
                            priority = "high",
                            width = 23,
                            height = 15,
                            frame_count = 4,
                            animation_speed = 0.5,
                            shift = util.by_pixel(3.5, -38),
                            scale = 0.5
                        }
                    }
                }
            },
            water_reflection = {
                pictures = {
                    filename = "__base__/graphics/entity/electric-furnace/electric-furnace-reflection.png",
                    priority = "extra-high",
                    width = 24,
                    height = 24,
                    shift = util.by_pixel(5, 40),
                    variation_count = 1,
                    scale = 5
                },
                rotate = false,
                orientation_to_variation = false
            }
        }
    }
)
