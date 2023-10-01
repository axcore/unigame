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
minetest.register_node("mineral:greenstone", {
	description = S("Greenstone"),
	tiles = {"mineral_greenstone.png"},
	is_ground_content = false,
	groups = {cracky = 1, stone = 1},
	drop = "mineral:greenstone",
	sounds = base.node_sound_stone_defaults(),
})

minetest.register_node("material:greenstone_brick", {
	description = "Greenstone Brick",
	tiles = {"material_greenstone_brick.png"},
	paramtype2 = "facedir",
	place_param2 = 0,
	groups = {cracky=1, stone=1},
	sounds = base.node_sound_stone_defaults(),
})
]]--
