data:extend(
    {
        {
            name = "coin_generation-private_research_institute_type",
            type = "string-setting",
            default_value = "none",
            allowed_values = {"none", "per_science", "grouped_science_non_space", "grouped_science_with_space"},
            setting_type = "startup",
            order = "1001"
        },
        {
            name = "coin_generation-private_research_institute_value_decrease_percent",
            type = "double-setting",
            default_value = 20,
            minimum_value = 0,
            maximum_value = 100,
            setting_type = "startup",
            order = "1001"
        }
    }
)

data:extend(
    {
        {
            name = "coin_generaton-player_biter_nest_kill_coins",
            type = "double-setting",
            default_value = 10,
            minimum_value = 0,
            setting_type = "runtime-global",
            order = "2001"
        },
        {
            name = "coin_generaton-player_biter_unit_kill_coins_multiplier",
            type = "double-setting",
            default_value = 1,
            minimum_value = 0,
            setting_type = "runtime-global",
            order = "2002"
        },
        {
            name = "coin_generaton-player_coin_collection_method",
            type = "string-setting",
            default_value = "inventory",
            allowed_values = {"inventory", "corpse"},
            setting_type = "runtime-global",
            order = "2003"
        },
        {
            name = "coin_generaton-non_player_coin_multiplier",
            type = "double-setting",
            default_value = 0.1,
            minimum_value = 0,
            setting_type = "runtime-global",
            order = "2101"
        },
        {
            name = "coin_generaton-non_player_coin_collection_method",
            type = "string-setting",
            default_value = "killer",
            allowed_values = {"killer", "corpse"},
            setting_type = "runtime-global",
            order = "2102"
        }
    }
)
if mods["prime_intergalactic_delivery"] then
    table.insert(data.raw["string-setting"]["coin_generaton-player_coin_collection_method"].allowed_values, "prime_intergalactic_delivery_payment_chest")
    table.insert(data.raw["string-setting"]["coin_generaton-non_player_coin_collection_method"].allowed_values, "prime_intergalactic_delivery_payment_chest")
end

--IM NOT CONVINCED ABOUT THIS
--[[
data:extend(
    {
        {
            name = "coin_generaton-coin_delivery_recipient",
            type = "string-setting",
            default_value = "per_player",
            allowed_values = {"each_player", "random_player"},
            setting_type = "runtime-global",
            order = "3001"
        },
        {
            name = "coin_generaton-coin_delivery_method",
            type = "string-setting",
            default_value = "inventory",
            allowed_values = {"inventory"},
            setting_type = "runtime-global",
            order = "3002"
        },
        {
            name = "coin_generaton-coin_delivery_time_min",
            type = "float-setting",
            default_value = 5,
            minimum_value = 1,
            setting_type = "runtime-global",
            order = "3003"
        },
        {
            name = "coin_generaton-coin_delivery_time_max",
            type = "float-setting",
            default_value = 30,
            minimum_value = 1,
            setting_type = "runtime-global",
            order = "3004"
        },
        {
            name = "coin_generaton-coin_delivery_coin_min",
            type = "int-setting",
            default_value = 100,
            minimum_value = 0,
            setting_type = "runtime-global",
            order = "3003"
        },
        {
            name = "coin_generaton-coin_delivery_coin_max",
            type = "int-setting",
            default_value = 1000,
            minimum_value = 0,
            setting_type = "runtime-global",
            order = "3004"
        }
    }
)
if mods["prime_intergalactic_delivery"] then
    table.insert(data.raw["string-setting"]["coin_generaton-coin_delivery_recipient"].allowed_values, "prime_intergalactic_delivery_payment_chest")
end
if mods["item_delivery_pod"] then
    table.insert(data.raw["string-setting"]["coin_generaton-coin_delivery_method"].allowed_values, "item_delivery_pod_ship")
    data:extend(
        {
            {
                name = "coin_generaton-coin_delivery_item_delivery_pod_ship_size_weight",
                type = "float-setting",
                default_value = 1,
                minimum_value = 0,
                setting_type = "runtime-global",
                order = "3010"
            },
            {
                name = "coin_generaton-coin_delivery_item_delivery_pod_ship_accuracy_weight",
                type = "float-setting",
                default_value = 1,
                minimum_value = 0,
                setting_type = "runtime-global",
                order = "3011"
            }
        }
    )
end
]]
