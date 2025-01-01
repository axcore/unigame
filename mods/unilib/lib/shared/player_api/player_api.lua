---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- player_api.lua
--      Make either minetest_game/player_api, or its unilib equivalent, available
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.player_api = {}

---------------------------------------------------------------------------------------------------
-- Wrapper functions to load files, as and when required
---------------------------------------------------------------------------------------------------

-- Player API functions. Use minetest_game/player_api if available; otherwise use unilib's version
if core.get_modpath("player_api") then
    dofile(unilib.core.path_mod .. "/lib/shared/player_api/player_api_mtgame.lua")
else
    dofile(unilib.core.path_mod .. "/lib/shared/player_api/player_api_unilib.lua")
end
