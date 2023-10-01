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
	minetest.register_node("lib_ecology:plant_vine_01", {
		description = S("Vine 01"),
		drawtype = "signlike",
		tiles = {"lib_ecology_plant_vine_01.png"},
		inventory_image = "lib_ecology_plant_vine_01.png",
		wield_image = "lib_ecology_plant_vine_01.png",
		paramtype = "light",
		paramtype2 = "wallmounted",
		waving = 1,
		floodable = true,
		walkable = false,
		climbable = true,
		is_ground_content = false,
		selection_box = {
			type = "wallmounted",
		},
		groups = {choppy = 3, oddly_breakable_by_hand = 1, lib_ecology_plant = 1},
		legacy_wallmounted = true,
		sounds = default.node_sound_leaves_defaults(),
	})
]]--
