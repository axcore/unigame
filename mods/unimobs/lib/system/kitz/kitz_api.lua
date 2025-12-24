---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- kitz_api.lua
--      Provide the API from the "petz/kitz" mod (which was itself an extension to the "mobkit" mod)
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

-- Create separate namespace for kitz API functions/constants
unimobs.kitz_api = {}
unimobs.kitz_const = {}

---------------------------------------------------------------------------------------------------
-- Set up constants
---------------------------------------------------------------------------------------------------

-- Was kitz.consts.DEFAULT_MAX_HEAR_DISTANCE
unimobs.kitz_const.default_max_hear_distance = 5
-- Was kitz.consts.DEFAULT_FEED_RATE
unimobs.kitz_const.default_feed_rate = 0.3
-- N.B. (kitz.consts.DEFAULT_FEED_COUNT has been replaced by a Minetest setting,
--      unimobs.petz_setting.default_tame_count)

---------------------------------------------------------------------------------------------------
-- Import files
---------------------------------------------------------------------------------------------------

dofile(unimobs.path_mod .. "/lib/system/kitz/kitz_active_mobs.lua")
dofile(unimobs.path_mod .. "/lib/system/kitz/kitz_clear_mobs.lua")
-- N.B. petz/kitz/api/api_commands.lua has been imported as the package "chat_clear_mobs"
-- N.B. petz/kitz/api/api_consts.lua has been imported above
dofile(unimobs.path_mod .. "/lib/system/kitz/kitz_cron.lua")
dofile(unimobs.path_mod .. "/lib/system/kitz/kitz_drops.lua")
dofile(unimobs.path_mod .. "/lib/system/kitz/kitz_feed_tame.lua")
dofile(unimobs.path_mod .. "/lib/system/kitz/kitz_maths.lua")
dofile(unimobs.path_mod .. "/lib/system/kitz/kitz_replace.lua")
dofile(unimobs.path_mod .. "/lib/system/kitz/kitz_sound.lua")
dofile(unimobs.path_mod .. "/lib/system/kitz/kitz_utils.lua")
