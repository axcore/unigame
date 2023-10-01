---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- init.lua
--      Initialise the mod
---------------------------------------------------------------------------------------------------

local S = minetest.get_translator(minetest.get_current_modname())

---------------------------------------------------------------------------------------------------
-- Create global namespaces
---------------------------------------------------------------------------------------------------

unilib = {}
unilib.pkg = {}

---------------------------------------------------------------------------------------------------
-- Set mod name/version
---------------------------------------------------------------------------------------------------

unilib.name = "unilib"

unilib.ver_max = 0
unilib.ver_min = 14
unilib.ver_rev = 143

unilib.intllib = S

---------------------------------------------------------------------------------------------------
-- Initial setup
---------------------------------------------------------------------------------------------------

unilib.log_header = "[UNILIB] "
minetest.log(unilib.log_header .. "Initialising...")

unilib.info_header = unilib.log_header
unilib.error_header = unilib.log_header .. "[" .. S("ERROR") .. "] "
unilib.warning_header = unilib.log_header .. "[" .. S("WARNING") .. "] "

unilib.path_world = minetest.get_worldpath()
unilib.path_mod = minetest.get_modpath(minetest.get_current_modname())

unilib.mod_storage = minetest.get_mod_storage()

---------------------------------------------------------------------------------------------------
-- Re-initialise the pseudo-random generator
---------------------------------------------------------------------------------------------------

math.randomseed(os.time())

---------------------------------------------------------------------------------------------------
-- Load files
---------------------------------------------------------------------------------------------------

-- Set up utility functions
dofile(unilib.path_mod .. "/lib/system/utils.lua")

-- Initialise global constants and variables, and import Minetest settings
dofile(unilib.path_mod .. "/lib/system/global.lua")
-- Override Minetest settings, if required
dofile(unilib.path_mod .. "/lib/system/override.lua")
-- Update global variables, now that override.lua has finished
dofile(unilib.path_mod .. "/lib/system/update.lua")

-- Register privileges
dofile(unilib.path_mod .. "/lib/system/privs.lua")
-- Initialise mod storage
dofile(unilib.path_mod .. "/lib/system/storage.lua")
-- Set up shared functions for registering things, replacing Minetest registration calls
dofile(unilib.path_mod .. "/lib/system/register.lua")
-- Set up unilib shared functions. This file contains a reference list of shared functions
dofile(unilib.path_mod .. "/lib/shared/shared.lua")
-- Set up unilib chat commands. This file contains a reference list of chat commands
dofile(unilib.path_mod .. "/lib/cmds/cmds.lua")
-- Set up unilib standard sound effects
dofile(unilib.path_mod .. "/lib/system/sounds.lua")

-- Set up the player effects that must be initialised before loading packages
dofile(unilib.path_mod .. "/lib/effects/cuisine.lua")
dofile(unilib.path_mod .. "/lib/effects/hydration.lua")

-- Read information about source/imported mods from CSV files in /csv/mod
-- Read information about one or more remixes from CSV files in /csv/remix
-- In case of a fatal error, reset global variables set by code in that file (which prevents
--      any packages from being imported)
dofile(unilib.path_mod .. "/lib/system/read_csv.lua")
-- Import all packages specified by the remix(es)
dofile(unilib.path_mod .. "/lib/system/import_pkg.lua")

-- Having imported everything, set up shared ABMs/LBMs
dofile(unilib.path_mod .. "/lib/system/abms.lua")
dofile(unilib.path_mod .. "/lib/system/lbms.lua")
-- ...and shared craft recipes
dofile(unilib.path_mod .. "/lib/system/crafting.lua")
-- ...and environmental sounds
dofile(unilib.path_mod .. "/lib/system/env_sounds.lua")
-- ...and remaining player effects
dofile(unilib.path_mod .. "/lib/effects/effects.lua")

-- Improve compatibility with inventory mods like unified_inventory
dofile(unilib.path_mod .. "/lib/system/inventory.lua")

---------------------------------------------------------------------------------------------------
-- Debug
---------------------------------------------------------------------------------------------------

-- (Any temporary debug code can go here. See also ../lib/cmds/test.lua)

---------------------------------------------------------------------------------------------------
-- Setup complete
---------------------------------------------------------------------------------------------------

-- As confirmation, show the number of packages imported for each remix
local msg = unilib.get_init_pkg_msg()
if msg ~= "" then
    minetest.log(unilib.log_header .. S("Imported packages from remixes:") .. msg)
else
    minetest.log(unilib.log_header .. S("No packages imported"))
end

-- Show the number of biomes/decorations/ores imported from remix CSVs (if any)
msg = unilib.get_init_biome_msg()
if msg ~= "" then
    minetest.log(unilib.log_header .. S("Imported biomes from remixes:") .. msg)
end

msg = unilib.get_init_deco_msg()
if msg ~= "" then
    minetest.log(unilib.log_header .. S("Imported decorations from remixes:") .. msg)
end

msg = unilib.get_init_ore_msg()
if msg ~= "" then
    minetest.log(unilib.log_header .. S("Imported ores from remixes:") .. msg)
end

minetest.log(
    unilib.log_header .. S(
        "This is an ALPHA RELEASE. It is 100% playable, but future releases may introduce" ..
        " game-breaking changes. Don\'t invest a lot of time and energy into your game (unless" ..
        " you are willing to maintain the code yourself)."
    )
)

minetest.log(unilib.log_header .. S("unilib is highly configurable. Please see the README."))
