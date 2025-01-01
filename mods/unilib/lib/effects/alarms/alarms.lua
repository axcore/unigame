---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- alarms.lua
--      Set up player alarms (original to unilib)
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.alarms = {}

---------------------------------------------------------------------------------------------------
-- Load files, as and when required
---------------------------------------------------------------------------------------------------

-- Set up player alarms
if not unilib.setting.debug_disable_effects_flag and
        (unilib.setting.debug_enable_effects_flag or unilib.setting.alarm_enable_flag) then
    dofile(unilib.core.path_mod .. "/lib/effects/alarms/alarms_base.lua")
else
    dofile(unilib.core.path_mod .. "/lib/effects/alarms/alarms_bu.lua")
end
