---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- global.lua
--      Initialise global constants and variables, and import Minetest settings
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.constant = {}
unilib.setting = {}
unilib.global = {}

---------------------------------------------------------------------------------------------------
-- Load files
---------------------------------------------------------------------------------------------------

-- Initialise global constants
dofile(unilib.core.path_mod .. "/lib/system/global/global_constants.lua")

-- Import Minetest settings as global variables
dofile(unilib.core.path_mod .. "/lib/system/global/global_settings.lua")
-- Override Minetest settings in code, when required
dofile(unilib.core.path_mod .. "/lib/system/global/global_override.lua")

-- Initialise other global variables
dofile(unilib.core.path_mod .. "/lib/system/global/global_variables.lua")

-- Modify the values of various global variables (including Minetest settings), when required
dofile(unilib.core.path_mod .. "/lib/system/global/global_update.lua")
