local Events = require("utility/events")
local BiterKilling = require("scripts/biter-killing")

local function CreateGlobals()
    BiterKilling.CreateGlobals()
end

local function OnLoad()
    --Any Remote Interface registration calls can go in here or in root of control.lua
    BiterKilling.OnLoad()
end

local function OnSettingChanged(event)
    BiterKilling.OnSettingChanged(event)
end

local function OnStartup()
    CreateGlobals()
    OnLoad()
    OnSettingChanged(nil)
end

script.on_init(OnStartup)
script.on_configuration_changed(OnStartup)
script.on_event(defines.events.on_runtime_mod_setting_changed, OnSettingChanged)
script.on_load(OnLoad)

Events.RegisterEvent(defines.events.on_entity_died, "TypeUnit-TypeTurret-TypeUnitSpawner", {{filter = "type", type = "unit"}, {filter = "type", type = "turret"}, {filter = "type", type = "unit-spawner"}})
