---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- init.lua
--      Initialise the mod
---------------------------------------------------------------------------------------------------

local S = core.get_translator(core.get_current_modname())

---------------------------------------------------------------------------------------------------
-- Create global namespaces
---------------------------------------------------------------------------------------------------

unimobs = {}

---------------------------------------------------------------------------------------------------
-- Set mod name/version
---------------------------------------------------------------------------------------------------

unimobs.name = "unimobs"

unimobs.ver_max = 1
unimobs.ver_min = 1
unimobs.ver_rev = 0

unimobs.intllib = S
-- (Strip context tags from translations, when required)
unimobs.strip_tags = function(str) return string.match(str, "^(.-)#") or str end

---------------------------------------------------------------------------------------------------
-- Set other core global variables
---------------------------------------------------------------------------------------------------

unimobs.path_mod = core.get_modpath(core.get_current_modname())

---------------------------------------------------------------------------------------------------
-- Initial setup
---------------------------------------------------------------------------------------------------

-- Tell unilib to use this mod as an expansion pack (in addition to any other expansion packs that
--      have already been loaded)
if not core.global_exists("unilib_expansion") then

    unilib_expansion = {}
    unilib_expansion.ext_pack_list = {"unimobs"}

else

    table.insert(unilib_expansion.ext_pack_list, "unimobs")

end

---------------------------------------------------------------------------------------------------
-- Load files - ../lib/system
---------------------------------------------------------------------------------------------------

-- Initialise global constants and variables, and import Minetest settings
dofile(unimobs.path_mod .. "/lib/system/main.lua")
-- Provide API from the "mobkit" mod
dofile(unimobs.path_mod .. "/lib/system/mobkit/mobkit_api.lua")
-- Provide API from the "petz" modpack
dofile(unimobs.path_mod .. "/lib/system/kitz/kitz_api.lua")
dofile(unimobs.path_mod .. "/lib/system/petz/petz_api.lua")
-- Provide API from various mods
dofile(unimobs.path_mod .. "/lib/system/misc/misc_api.lua")
-- Enable server calls from the "petz" modpack
dofile(unimobs.path_mod .. "/lib/system/petz/petz_cron.lua")
