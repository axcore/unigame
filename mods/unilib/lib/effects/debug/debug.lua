---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- debug.lua
--      Set up various debug effects
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

--unilib.debug = {}

---------------------------------------------------------------------------------------------------
-- Load files, as and when required
---------------------------------------------------------------------------------------------------

-- Make all nodes/craftitems/tools visible in creative inventory
if unilib.setting.debug_all_inventory_flag then
    dofile(unilib.core.path_mod .. "/lib/effects/debug/debug_inventory.lua")
end

-- Tweak all nodes to emit light
if unilib.setting.debug_force_light_source then
    dofile(unilib.core.path_mod .. "/lib/effects/debug/debug_light.lua")
end

-- Add node/craftitem/tool's full_name to its description, so it's visible in the player inventory
if unilib.setting.debug_add_name_flag then
    dofile(unilib.core.path_mod .. "/lib/effects/debug/debug_name.lua")
end

-- Add node/craftitem/tool's original name to its description, so it's visible in player inventory
if unilib.setting.debug_add_orig_name_flag then
    dofile(unilib.core.path_mod .. "/lib/effects/debug/debug_orig_name.lua")
end

-- Make stone nodes transparent, and disable falling nodes
if unilib.setting.debug_xray_flag then
    dofile(unilib.core.path_mod .. "/lib/effects/debug/debug_xray.lua")
end
