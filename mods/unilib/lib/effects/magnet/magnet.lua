---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- magnet.lua
--      Set up Minecraft-style item drop/get. Code adapted from the "item_drop" mod
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.magnet = {}

---------------------------------------------------------------------------------------------------
-- Load files, as and when required
---------------------------------------------------------------------------------------------------

-- Set up Minecraft-style item drop/get
if not unilib.setting.debug_disable_effects_flag and
        (unilib.setting.debug_enable_effects_flag or unilib.setting.magnet_auto_get_flag) then
    dofile(unilib.core.path_mod .. "/lib/effects/magnet/magnet_get_base.lua")
else
    dofile(unilib.core.path_mod .. "/lib/effects/magnet/magnet_get_bu.lua")
end

if not unilib.setting.debug_disable_effects_flag and
        (unilib.setting.debug_enable_effects_flag or unilib.setting.magnet_auto_drop_flag) then
    dofile(unilib.core.path_mod .. "/lib/effects/magnet/magnet_drop_base.lua")
else
    dofile(unilib.core.path_mod .. "/lib/effects/magnet/magnet_drop_bu.lua")
end

if not unilib.setting.debug_disable_effects_flag and (
    unilib.setting.debug_enable_effects_flag or
    unilib.setting.magnet_auto_get_flag or
    unilib.setting.magnet_auto_drop_flag
) then
    dofile(unilib.core.path_mod .. "/lib/effects/magnet/magnet_override_base.lua")
else
    dofile(unilib.core.path_mod .. "/lib/effects/magnet/magnet_override_bu.lua")
end
