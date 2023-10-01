---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    sickles
-- Code:    LGPL v3
-- Media:   CC BY-SA 3.0/4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("sickles:petals", {
	description = S("Flower Petals"),
	tiles = { "nature_blossom.png" },
	inventory_image = "nature_blossom.png",
	wield_image = "nature_blossom.png",
	is_ground_content = false,
	groups = { snappy = 3, attached_node = 1 },
	sounds = default.node_sound_leaves_defaults(),
	use_texture_alpha = true,
	drawtype = "signlike",
	paramtype = "light",
	paramtype2 = "wallmounted",
	node_box = node_box,
	selection_box = node_box,
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	floodable = true
})

-- enable crafting of flower petals
if mod_flowers then
	minetest.register_craft({
		output = "sickles:petals",
		recipe = {
			{ "flowers:dandelion_white", "flowers:dandelion_white" },
			{ "flowers:dandelion_white", "flowers:dandelion_white" },
		}
	})
end
]]--
