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
minetest.register_node("decoblocks:framed_glass", {
	description = "Glass With Wooden Frame",
	drawtype = "glasslike_framed_optional",
	tiles = {"decoblocks_framed_glass.png", "decoblocks_framed_glass_detail.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_craft({
	output = 'decoblocks:framed_glass',
	recipe = {
		{'', 'default:stick', ''},
		{'default:stick', 'default:glass', 'default:stick'},
		{'', 'default:stick', ''},
	}
})

minetest.register_node("decoblocks:broken_glass", {
	description = "Broken Glass",
	drawtype = "glasslike_framed_optional",
	tiles = {"decoblocks_broken_glass.png", "decoblocks_broken_glass_detail.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_craft({
	type = "shapeless",
	output = 'decoblocks:broken_glass',
	recipe = {
		'decoblocks:framed_glass',
		'vessels:glass_fragments',
		'default:stick',
	}
})
]]--
