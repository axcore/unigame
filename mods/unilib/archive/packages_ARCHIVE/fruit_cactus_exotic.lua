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
minetest.register_node("fruit:cactus_fruit", {
	description = "Cactus Fruit",
	drawtype = "plantlike",
	tiles = {
		"fruit_cactus.png",
	},
	paramtype = "light",
	groups = {fleshy=1, dig_immediate=3, oddly_breakable_by_hand=1,},
	inventory_image = "fruit_cactus_inv.png",
	wield_image = "fruit_cactus_inv.png",
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.3, -0.4, -0.3, 0.3, -0.5, 0.3}, 
		}
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.3, -0.4, -0.3, 0.3, -0.5, 0.3}, 
		}
	},
	on_use = minetest.item_eat(2)
})
]]--
