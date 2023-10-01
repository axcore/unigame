---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("real_minerals:peat", {
	description = S("Peat"),
	tiles = {"real_minerals_peat_ore.png"},
	particle_image = {"real_minerals_peat_ore.png"},
	groups = {crumbly=3,drop_on_dig=1,falling_node=1},
	sounds = default.node_sound_dirt_defaults(),
})
minetest.register_craft({
	type = "fuel",
	recipe = "real_minerals:peat",
	burntime = 15
})
]]--
