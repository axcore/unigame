---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- atmosphere.lua
--      Set up weather and ambient effects
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.atmosphere = {}

---------------------------------------------------------------------------------------------------
-- Load files, as and when required
---------------------------------------------------------------------------------------------------

-- Set up weather and ambient effects
if not unilib.setting.debug_disable_effects_flag and (
    unilib.setting.atmosphere_weather_enable_flag or
    unilib.setting.atmosphere_ambient_enable_flag or
    unilib.setting.atmosphere_environment_enable_flag
) then
    dofile(unilib.core.path_mod .. "/lib/effects/atmosphere/atmosphere_base.lua")
else
    dofile(unilib.core.path_mod .. "/lib/effects/atmosphere/atmosphere_bu.lua")
end
