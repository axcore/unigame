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
minetest.register_node("mineral:bluestone", {
	description = S("Bluestone"),
	tiles = {"mineral_bluestone.png"},
	is_ground_content = false,
	groups = {cracky = 3, stone = 1},
	drop = "mineral:bluestone_cobble",
	sounds = base.node_sound_stone_defaults(),
})

minetest.register_node("material:basalt_brick", {
	description = "Basalt Brick",
	tiles = {"material_basalt_brick.png"},
	paramtype2 = "facedir",
	place_param2 = 0,
	groups = {cracky=1, stone=1},
	sounds = base.node_sound_stone_defaults(),
})

minetest.register_node("mineral:bluestone_cobble", {
	description = S("Blue Cobble"),
	tiles = {"mineral_bluestone_cobble.png"},
	is_ground_content = false,
	groups = {cracky = 3, stone = 2},
	sounds = base.node_sound_stone_defaults(),
})
]]--
