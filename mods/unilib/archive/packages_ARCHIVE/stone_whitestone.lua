---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    grailtest/material
-- Code:    LGPL v2.1
-- Media:   CC BY-SA
--
-- From:    grailtest/mineral
-- Code:    LGPL v2.1
-- Media:   CC BY-SA
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("mineral:white_stone", {
	description = S("White Stone"),
	tiles = {"mineral_white_stone.png"},
	is_ground_content = false,
	groups = {cracky = 3},
	drop = "mineral:white_cobble",
	sounds = base.node_sound_stone_defaults(),
})

minetest.register_node("material:whitestone_brick", {
	description = "Whitestone Brick",
	tiles = {"material_whitestone_brick.png"},
	paramtype2 = "facedir",
	place_param2 = 0,
	groups = {cracky=2},
	sounds = base.node_sound_stone_defaults(),
})

minetest.register_node("mineral:white_cobble", {
	description = S("White Cobble"),
	tiles = {"mineral_white_cobble.png"},
	is_ground_content = false,
	groups = {cracky = 3},
	sounds = base.node_sound_stone_defaults(),
})
]]--
