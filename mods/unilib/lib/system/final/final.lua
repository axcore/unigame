---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- final.lua
--      Run finalisation code
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Table of files loaded
local t = {}

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

--unilib.final = {}

---------------------------------------------------------------------------------------------------
-- Load files, as and when required
---------------------------------------------------------------------------------------------------

if #unilib.global.obsolete_abm_list > 0 or #unilib.global.obsolete_lbm_list > 0 then

    -- Disable obsolete minetest_game ABMs/LBMs
    dofile(unilib.core.path_mod .. "/lib/system/final/final_abm_lbm.lua")

end

if unilib.global.pkg_loaded_list then

    -- Set up environmental sounds
    dofile(unilib.core.path_mod .. "/lib/system/final/final_env_sound.lua")

    -- Set up tree trunks as fuel
    dofile(unilib.core.path_mod .. "/lib/system/final/final_fuel.lua")

    -- Set up tool repair
    dofile(unilib.core.path_mod .. "/lib/system/final/final_repair.lua")

end

-- Improve compatibility with the "unified_inventory" mod, if loaded
if unilib.setting.unified_inventory_update_flag then
    dofile(unilib.core.path_mod .. "/lib/system/final/final_compat_ui.lua")
end
