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
minetest.register_node("fruit:apple", {
	description = "Apple",
	drawtype = "plantlike",
	tiles = {
		"default_apple.png",
	},
	inventory_image = "default_apple.png",
	wield_image = "default_apple.png",
	paramtype = "light",
	groups = {snappy=1, dig_immediate=3, oddly_breakable_by_hand=1},
	on_use = minetest.item_eat(2),
	sounds = default.node_sound_leaves_defaults()
})
]]--
