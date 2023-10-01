---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("lib_ecology:mushroom_03_stem", {
	description = S("Mushroom 03 Stem"),
	tiles = {"lib_ecology_mushroom_01_trunk_top.png", "lib_ecology_mushroom_01_trunk_top.png", "lib_ecology_mushroom_03_trunk.png"},
	is_ground_content = false,
	groups = {tree=1,choppy=2,oddly_breakable_by_hand=1,flammable=2, plant=1},
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	drawtype = "nodebox",
	node_box = { type = "fixed", fixed = { {-0.25, -0.5, -0.25, 0.25, 0.5, 0.25}, }},
})
minetest.register_node("lib_ecology:mushroom_03_cap_giant", {
	description = S("Mushroom 03 Cap Giant"),
	tiles = {"lib_ecology_mushroom_03_cap.png", "lib_ecology_mushroom_03_spores.png", "lib_ecology_mushroom_03_cap.png"},
	is_ground_content = false,
	paramtype = "light",
	drawtype = "nodebox",
	node_box = { type = "fixed", 
		fixed = {
			{-0.4, -0.5, -0.4, 0.4, 0.0, 0.4},
			{-0.75, -0.5, -0.4, -0.4, -0.25, 0.4},
			{0.4, -0.5, -0.4, 0.75, -0.25, 0.4},
			{-0.4, -0.5, -0.75, 0.4, -0.25, -0.4},
			{-0.4, -0.5, 0.4, 0.4, -0.25, 0.75},
		} },
	groups = {fleshy=1, dig_immediate=3, flammable=2, plant=1, leafdecay=1},
})
minetest.register_node("lib_ecology:mushroom_03_cap_huge", {
	description = S("Mushroom 03 Cap Huge"),
	tiles = {"lib_ecology_mushroom_03_cap.png", "lib_ecology_mushroom_03_spores.png", "lib_ecology_mushroom_03_cap.png"},
	is_ground_content = false,
	paramtype = "light",
	drawtype = "nodebox",
	node_box = { type = "fixed", 
		fixed = {
			{-0.5, -0.5, -0.33, 0.5, -0.33, 0.33}, 
			{-0.33, -0.5, 0.33, 0.33, -0.33, 0.5}, 
			{-0.33, -0.5, -0.33, 0.33, -0.33, -0.5}, 
			{-0.33, -0.33, -0.33, 0.33, -0.17, 0.33}, 
		} },
	groups = {fleshy=1, dig_immediate=3, flammable=2, plant=1, leafdecay=1},
})
]]--
