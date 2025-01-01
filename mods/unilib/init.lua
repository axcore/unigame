---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- init.lua
--      Initialise the mod
---------------------------------------------------------------------------------------------------

local S = core.get_translator(core.get_current_modname())

---------------------------------------------------------------------------------------------------
-- Create global namespaces
---------------------------------------------------------------------------------------------------

unilib = {}
unilib.core = {}
unilib.pkg = {}

---------------------------------------------------------------------------------------------------
-- Set mod name/version
---------------------------------------------------------------------------------------------------

unilib.core.name = "unilib"

unilib.core.ver_max = 1
unilib.core.ver_min = 0
unilib.core.ver_rev = 0

unilib.intllib = S

---------------------------------------------------------------------------------------------------
-- Set other core global variables
---------------------------------------------------------------------------------------------------

unilib.core.log_header = "[UNILIB] "
unilib.core.info_header = unilib.core.log_header
unilib.core.error_header = unilib.core.log_header .. "[" .. S("ERROR") .. "] "
unilib.core.warning_header = unilib.core.log_header .. "[" .. S("WARNING") .. "] "

-- N.B. This setting is later stored as unilib.setting.show_startup_msg_flag
local show_flag = core.settings:get_bool("unilib_show_startup_msg_flag", false)
if show_flag then

    core.log(
        unilib.core.log_header .. "Initialising " .. unilib.core.name .. " v" ..
                unilib.core.ver_max .. "." .. unilib.core.ver_min .. "." .. unilib.core.ver_rev ..
                "..."
    )

    -- Same check as the one used by the current version of minetest_game/default
    -- (Itemstack.add_wear_by_uses() was added in Minetest v5.6.0)
    if ItemStack("").add_wear_by_uses == nil then

        core.log(
            unilib.core.warning_header .. S(
                "unilib may not work well with older engines; consider updating your engine"
            )
        )

    end

end

unilib.core.path_world = core.get_worldpath()
unilib.core.path_mod = core.get_modpath(core.get_current_modname())
-- The name of the game on top of which unilib is running (for minetest_game, the value "minetest")
unilib.core.current_game = Settings(unilib.core.path_world .. DIR_DELIM .. 'world.mt'):get('gameid')

unilib.core.mod_storage = core.get_mod_storage()

---------------------------------------------------------------------------------------------------
-- Main setup
---------------------------------------------------------------------------------------------------

dofile(unilib.core.path_mod .. "/lib/main.lua")

---------------------------------------------------------------------------------------------------
-- Debug
---------------------------------------------------------------------------------------------------

-- (Any temporary debug code can go here. See also the package ../lib/pkgs/chat_test.lua)

---------------------------------------------------------------------------------------------------
-- Setup complete
---------------------------------------------------------------------------------------------------

if show_flag then

    -- As confirmation, show the number of packages imported for each remix
    local msg = unilib.utils.get_startup_pkg_msg()
    if msg ~= "" then
        core.log(unilib.core.log_header .. S("Imported packages from remixes:") .. msg)
    else
        core.log(unilib.core.log_header .. S("No packages imported"))
    end

    -- Show the number of biomes/decorations/ores imported from remix CSVs (if any)
    msg = unilib.utils.get_startup_biome_msg()
    if msg ~= "" then
        core.log(unilib.core.log_header .. S("Imported biomes from remix CSVs:") .. msg)
    end

    msg = unilib.utils.get_startup_deco_msg()
    if msg ~= "" then
        core.log(unilib.core.log_header .. S("Imported decorations from remix CSVs:") .. msg)
    end

    msg = unilib.utils.get_startup_ore_msg()
    if msg ~= "" then
        core.log(unilib.core.log_header .. S("Imported ores from remix CSVs:") .. msg)
    end

    -- Show any expansion packs that were detected
    msg = unilib.utils.get_startup_expansion_msg()
    if msg ~= "" then
        core.log(unilib.core.log_header .. S("Detected expansion packs:") .. msg)
    end

end
