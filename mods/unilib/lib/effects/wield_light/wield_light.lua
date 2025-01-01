---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- wield_light.lua
--      Set up wielded light effects. Code adapted from the "wielded_light" mod
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.wield_light = {}

---------------------------------------------------------------------------------------------------
-- Load files, as and when required
---------------------------------------------------------------------------------------------------

-- Set up wielded light effects
if not unilib.setting.debug_disable_effects_flag and
        (unilib.setting.debug_enable_effects_flag or unilib.setting.wield_light_flag) then
    dofile(unilib.core.path_mod .. "/lib/effects/wield_light/wield_light_base.lua")
else
    dofile(unilib.core.path_mod .. "/lib/effects/wield_light/wield_light_bu.lua")
end
