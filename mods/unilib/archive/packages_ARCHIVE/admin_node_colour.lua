---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    maptools
-- Code:    zlib
-- Media:   zlib
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
register_node("maptools:black", {
	description = S("Black"),
	tiles = {"black.png"},
	post_effect_color = {a=255, r=0, g=0, b=0},
	sounds = default.node_sound_stone_defaults(),
})

register_node("maptools:white", {
	description = S("White"),
	tiles = {"white.png"},
	post_effect_color = {a=255, r=128, g=128, b=128},
	sounds = default.node_sound_stone_defaults(),
})
]]--
