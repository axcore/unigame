---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- flooding.lua
--      Set up flooding and flushing effects. Code adapted from "farming_flood" mod
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

--unilib.flooding = {}

---------------------------------------------------------------------------------------------------
-- Load files, as and when required
---------------------------------------------------------------------------------------------------

-- Set up flooding and flushing effects
if not unilib.setting.debug_disable_effects_flag and (
    unilib.setting.debug_enable_effects_flag or
    unilib.setting.floodable_flora_flag or
    unilib.setting.flushable_flora_flag
) then
    dofile(unilib.core.path_mod .. "/lib/effects/flooding/flooding_base.lua")
end
