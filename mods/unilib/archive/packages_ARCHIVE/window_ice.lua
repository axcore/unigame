---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("mtg_plus:ice_window", {
	description = S("Ice Window"),
	_doc_items_longdesc = S("This decorational ice tile has been crafted in a way that it is partially transparent and looks like a real window."),
	drawtype = "glasslike",
	tiles = {"mtg_plus_ice_window.png"},
	sunlight_propagates = true,
	groups = {cracky = 3, cools_lava = 1, slippery = 3 },
	is_ground_content = false,
	paramtype = "light",
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_craft({
	output = "mtg_plus:ice_window",
	type = "cooking",
	recipe = "mtg_plus:ice_tile4",
	cooktime = 1,
})

if minetest.get_modpath("moreblocks") then
	minetest.register_craft({
		type = "shapeless",
		output = "mtg_plus:ice_window",
		recipe = { "mtg_plus:ice_tile4", "moreblocks:sweeper" },
	})
end
]]--
