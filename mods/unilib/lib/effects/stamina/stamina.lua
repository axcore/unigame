---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- stamina.lua
--      Set up hunger and sprinting fatigue. Code adapted from the "stamina" mod
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.stamina = {}

---------------------------------------------------------------------------------------------------
-- Load files, as and when required
---------------------------------------------------------------------------------------------------

-- Set up hunger and sprinting fatigue
if not unilib.setting.debug_disable_effects_flag and
        (unilib.setting.debug_enable_effects_flag or unilib.setting.hunger_enable_flag) then
    dofile(unilib.core.path_mod .. "/lib/effects/stamina/stamina_base.lua")
else
    dofile(unilib.core.path_mod .. "/lib/effects/stamina/stamina_bu.lua")
end
