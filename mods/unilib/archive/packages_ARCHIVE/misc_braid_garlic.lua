---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("farming:garlic_braid", {
	description = S("Garlic Braid"),
	inventory_image = "crops_garlic_braid.png",
	wield_image = "crops_garlic_braid.png",
	drawtype = "nodebox",
	use_texture_alpha = "clip",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {
		"crops_garlic_braid_side.png","crops_garlic_braid.png",
		"crops_garlic_braid_side.png^[transformFx","crops_garlic_braid_side.png",
		"crops_garlic_braid.png","crops_garlic_braid.png"
	},
	groups = {vessel = 1, dig_immediate = 3, flammable = 3},
	sounds = default.node_sound_leaves_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
				{-0.13, -0.45, 0.5, 0.13, 0.45, 0.24}
		}
	}
})
minetest.register_craft({
	output = "farming:garlic_braid",
	recipe = {
		{"farming:garlic", "farming:garlic", "farming:garlic"},
		{"farming:garlic", "farming:garlic", "farming:garlic"},
		{"farming:garlic", "farming:garlic", "farming:garlic"}
	}
})
minetest.register_craft({
	type = "shapeless",
	output = "farming:garlic 9",
	recipe = {"farming:garlic_braid"}
})
]]--
