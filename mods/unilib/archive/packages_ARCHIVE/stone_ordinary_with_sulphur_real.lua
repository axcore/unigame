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
minetest.register_node("real_minerals:sulfur_in_stone", {
	description = S('Sulfur'),
	tiles = {"default_stone.png^real_minerals_sulfur_ore.png"},
	particle_image = {"real_minerals_sulfur_ore.png"},
	paramtype = "light",
	groups = {cracky=3,drop_on_dig=1,dig_immediate=2},
	drop = {
		max_items = 1,
		items = {
			{
				items = {"minerals:sulfur 3"},
				rarity = 15,
			},
			{
				items = {"minerals:sulfur 2"},
			}
		}
	},
})
]]--
