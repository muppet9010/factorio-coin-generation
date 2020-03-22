local BiterKilling = {}
local Events = require("utility/events")
local Utils = require("utility/utils")
local Logging = require("utility/logging")

BiterKilling.CreateGlobals = function()
    global.biterKilling = global.biterKilling or {}
    global.biterKilling.entityValuePlayer = global.biterKilling.entityValuePlayer or {}
    global.biterKilling.entityValueNonPlayer = global.biterKilling.entityValueNonPlayer or {}
    global.biterKilling.playerNestValue = global.biterKilling.playerNestValue or 0
    global.biterKilling.playerUnitValueMultiplier = global.biterKilling.playerUnitValueMultiplier or 0
    global.biterKilling.playerCoinMode = global.biterKilling.playerCoinMode or "inventory"
    global.biterKilling.nonPlayerCoinMultiplier = global.biterKilling.nonPlayerCoinMultiplier or 0
    global.biterKilling.nonPlayerCoinMode = global.biterKilling.nonPlayerCoinMode or "killer"
end

BiterKilling.OnLoad = function()
    Events.RegisterEvent(defines.events.on_entity_died, "BiterKilling.OnEntityDied", {{filter = "type", type = "unit"}, {filter = "type", type = "turret"}, {filter = "type", type = "unit-spawner"}})
    Events.RegisterHandler(defines.events.on_entity_died, "BiterKilling.OnEntityDied", BiterKilling.OnEntityDied)
end

BiterKilling.OnSettingChanged = function(event)
    local updateEntityValueTable = false
    if event == nil or event.setting == "coin_generaton-player_biter_nest_kill_coins" then
        global.biterKilling.playerNestValue = tonumber(settings.global["coin_generaton-player_biter_nest_kill_coins"].value)
        updateEntityValueTable = true
    end
    if event == nil or event.setting == "coin_generaton-player_biter_unit_kill_coins_multiplier" then
        global.biterKilling.playerUnitValueMultiplier = tonumber(settings.global["coin_generaton-player_biter_unit_kill_coins_multiplier"].value)
        updateEntityValueTable = true
    end
    if event == nil or event.setting == "coin_generaton-player_coin_collection_method" then
        global.biterKilling.playerCoinMode = settings.global["coin_generaton-player_coin_collection_method"].value
    end
    if event == nil or event.setting == "coin_generaton-non_player_coin_multiplier" then
        global.biterKilling.nonPlayerCoinMultiplier = tonumber(settings.global["coin_generaton-non_player_coin_multiplier"].value)
        updateEntityValueTable = true
    end
    if event == nil or event.setting == "coin_generaton-non_player_coin_collection_method" then
        global.biterKilling.nonPlayerCoinMode = settings.global["coin_generaton-non_player_coin_collection_method"].value
    end

    if updateEntityValueTable then
        BiterKilling.CalculateEntityValues()
    end
end

BiterKilling.OnEntityDied = function(event)
    if global.biterKilling.playerNestValue == 0 and global.biterKilling.playerUnitValueMultiplier == 0 and global.biterKilling.nonPlayerCoinMultiplier == 0 then
        return
    end

    local killer = event.cause
    local diedEntity = event.entity
    local isPlayer, coinValue

    if diedEntity.force == "player" then
        return
    end
    if diedEntity.type ~= "unit" and diedEntity.type ~= "turret" and diedEntity.type ~= "unit-spawner" then
        return
    end
    if string.sub(diedEntity.name, 1, string.len("mining-drone-attack-proxy-new")) == "mining-drone-attack-proxy-new" then
        --Is a mining drone attack proxy thats died.
        return
    end

    if killer ~= nil and killer.type == "character" then
        isPlayer = true
        coinValue = Utils.HandleFloatNumberAsChancedValue(global.biterKilling.entityValuePlayer[diedEntity.name])
    elseif killer ~= nil and killer.type == "car" then
        if killer.get_driver() ~= nil then
            killer = killer.get_driver()
        end
        isPlayer = true
        coinValue = Utils.HandleFloatNumberAsChancedValue(global.biterKilling.entityValuePlayer[diedEntity.name])
    else
        isPlayer = false
        coinValue = Utils.HandleFloatNumberAsChancedValue(global.biterKilling.entityValueNonPlayer[diedEntity.name])
    end
    if coinValue <= 0 then
        return
    end

    if isPlayer then
        if global.biterKilling.playerCoinMode == "inventory" then
            if killer == nil then
                diedEntity.surface.spill_item_stack(diedEntity.position, {name = "coin", count = coinValue}, true, nil, false)
                return
            end
            local inserted = killer.insert({name = "coin", count = coinValue})
            if inserted < coinValue then
                killer.surface.spill_item_stack(killer.position, {name = "coin", counr = coinValue - inserted}, true, nil, false)
            end
        elseif global.biterKilling.playerCoinMode == "corpse" then
            diedEntity.surface.spill_item_stack(diedEntity.position, {name = "coin", count = coinValue}, true, nil, false)
        elseif global.biterKilling.playerCoinMode == "prime_intergalactic_delivery_payment_chest" then
            local paymentChest = remote.call("prime_intergalactic_delivery", "get_payment_chest")
            if paymentChest == nil then
                Logging.LogPrint("Error: Coin Generation - give coins for kills can't get payment chest.")
                return
            end
            local inserted = paymentChest.insert({name = "coin", count = coinValue})
            if inserted < coinValue then
                paymentChest.surface.spill_item_stack(paymentChest.position, {name = "coin", count = coinValue - inserted}, true, nil, false)
            end
        else
            Logging.LogPrint("Error: Coin Generation - give coins for kills has invalid playerCoinMode: " .. global.biterKilling.playerCoinMode)
            return
        end
    else
        if global.biterKilling.nonPlayerCoinMode == "killer" then
            if killer == nil then
                diedEntity.surface.spill_item_stack(diedEntity.position, {name = "coin", count = coinValue}, true, nil, false)
                return
            end
            killer.surface.spill_item_stack(killer.position, {name = "coin", count = coinValue}, true, nil, true)
        elseif global.biterKilling.nonPlayerCoinMode == "corpse" then
            diedEntity.surface.spill_item_stack(diedEntity.position, {name = "coin", count = coinValue}, true, nil, false)
        elseif global.biterKilling.nonPlayerCoinMode == "prime_intergalactic_delivery_payment_chest" then
            local paymentChest = remote.call("prime_intergalactic_delivery", "get_payment_chest")
            if paymentChest == nil then
                Logging.LogPrint("Error: Coin Generation - give coins for kills can't get payment chest.")
                return
            end
            local inserted = paymentChest.insert({name = "coin", count = coinValue})
            if inserted < coinValue then
                paymentChest.surface.spill_item_stack(paymentChest.position, {name = "coin", count = coinValue - inserted}, true, nil, false)
            end
        else
            Logging.LogPrint("Error: Coin Generation - give coins for kills has invalid nonPlayerCoinMode: " .. global.biterKilling.nonPlayerCoinMode)
            return
        end
    end
end

BiterKilling.CalculateEntityValues = function()
    global.biterKilling.entityValue = {}
    for _, prototype in pairs(game.get_filtered_entity_prototypes({{filter = "type", type = "unit"}, {filter = "type", type = "turret"}})) do
        local playerCoinValue = ((prototype.max_health ^ (1 / 3)) / 2) * global.biterKilling.playerUnitValueMultiplier
        local nonPlayerCoinValue = playerCoinValue * global.biterKilling.nonPlayerCoinMultiplier
        global.biterKilling.entityValuePlayer[prototype.name] = playerCoinValue
        global.biterKilling.entityValueNonPlayer[prototype.name] = nonPlayerCoinValue
    end
    for _, prototype in pairs(game.get_filtered_entity_prototypes({{filter = "type", type = "unit-spawner"}})) do
        local playerCoinValue = global.biterKilling.playerNestValue
        local nonPlayerCoinValue = playerCoinValue * global.biterKilling.nonPlayerCoinMultiplier
        global.biterKilling.entityValuePlayer[prototype.name] = playerCoinValue
        global.biterKilling.entityValueNonPlayer[prototype.name] = nonPlayerCoinValue
    end
end

return BiterKilling
