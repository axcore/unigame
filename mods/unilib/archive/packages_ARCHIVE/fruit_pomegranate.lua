---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/pomegranate
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("pomegranate:pomegranate", {
	description = S("Pomegranate"),
	drawtype = "plantlike",
	tiles = {"pomegranate.png"},
	inventory_image = "pomegranate.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {-3 / 16, -7 / 16, -3 / 16, 3 / 16, 4 / 16, 3 / 16}
	},
	groups = {fleshy = 3, dig_immediate = 3, flammable = 2,
		leafdecay = 3, leafdecay_drop = 1},
	on_use = minetest.item_eat(2),
	sounds = default.node_sound_leaves_defaults(),

	after_place_node = function(pos, placer, itemstack)
		minetest.set_node(pos, {name = "pomegranate:pomegranate", param2 = 1})
	end,
})

minetest.register_craftitem("pomegranate:section", {
	description = S("Pomegranate Section"),
	inventory_image = "pomegranate_section.png",
	on_use = minetest.item_eat(3),
	groups = {flammable = 2, food = 2},
})
minetest.register_craft({
	output = "pomegranate:section 4",
	recipe = {{"pomegranate:pomegranate"}}
})
]]--
