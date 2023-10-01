---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("decoblocks:bone_pillar", {
	description = "Bone Pillar",
	tiles = {"decoblocks_bone_pillar_top.png", "decoblocks_bone_pillar_top.png", "decoblocks_bone_pillar.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {cracky = 3, stone = 2},
	sounds = default.node_sound_stone_defaults(),

	on_place = minetest.rotate_node
})
minetest.register_craft({
	output = 'decoblocks:bone_pillar',
	recipe = {
		{'witchcraft:bone', 'witchcraft:bone'},
		{'witchcraft:bone', 'witchcraft:bone'},
	}
})
]]--
