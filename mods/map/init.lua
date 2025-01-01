-- map/init.lua

-- Mod global namespace

map = {}


-- Load support for MT game translation.
local S = minetest.get_translator("map")


-- Update HUD flags
-- Global to allow overriding

function map.update_hud_flags(player) end
